require "application_system_test_case"
require "minitest/mock"

# The photo auto-fill checks the number and size of the chosen images in the
# browser, so a selection the server would reject never gets uploaded.
class HealthCheckOcrUploadSystemTest < ApplicationSystemTestCase
  setup do
    @pet = pets(:one)
    @png = file_fixture("lab_report.png").to_s
    @tempfiles = []
    sign_in_as(users(:one))
    visit new_pet_health_check_url(pet_id: @pet, locale: I18n.default_locale)
    # count upload requests the page makes
    page.execute_script(<<~JS)
      window.__ocrUploads = 0;
      const originalFetch = window.fetch;
      window.fetch = (...args) => { if (String(args[0]).includes("extract_data")) window.__ocrUploads++; return originalFetch.apply(window, args); };
    JS
  end

  teardown do
    @tempfiles.each(&:close!)
  end

  test "too many images are refused before uploading" do
    attach_file "ocr_file_upload", Array.new(GeminiOcrService::MAX_FILES + 1) { copy_of(@png) }, make_visible: true
    assert_selector "[data-ocr-upload-target='status']", text: I18n.t("services.gemini_ocr.too_many_files", max: GeminiOcrService::MAX_FILES)
    assert_equal 0, page.evaluate_script("window.__ocrUploads")
  end

  test "an image over the size limit is refused before uploading" do
    attach_file "ocr_file_upload", [ file_of_size(GeminiOcrService::MAX_FILE_SIZE + 1) ], make_visible: true
    assert_selector "[data-ocr-upload-target='status']", text: I18n.t("services.gemini_ocr.file_too_large", max: "10 MB")
    assert_equal 0, page.evaluate_script("window.__ocrUploads")
  end

  test "images that are too large together are refused before uploading" do
    each_size = GeminiOcrService::MAX_TOTAL_SIZE / 2 + 1
    attach_file "ocr_file_upload", [ file_of_size(each_size), file_of_size(each_size) ], make_visible: true
    assert_selector "[data-ocr-upload-target='status']", text: I18n.t("services.gemini_ocr.total_too_large", max: "14 MB")
    assert_equal 0, page.evaluate_script("window.__ocrUploads")
  end

  test "a valid image is uploaded and fills in the form" do
    fake_service = Object.new
    fake_service.define_singleton_method(:call) { { "crea" => 1.2 } }
    # a lambda: minitest calls any stub value that responds to #call instead of returning it
    GeminiOcrService.stub(:new, ->(*) { fake_service }) do
      attach_file "ocr_file_upload", [ @png ], make_visible: true
      assert_selector "[data-ocr-upload-target='status']", text: I18n.t("shared.ocr_auto_fill.status_success"), wait: 10
      assert_field "health_check_crea", with: "1.2"
    end
    assert_equal 1, page.evaluate_script("window.__ocrUploads")
  end

  private
    def copy_of(path)
      file = Tempfile.new([ "report", ".png" ])
      file.binmode
      file.write(File.binread(path))
      file.flush
      @tempfiles << file
      file.path
    end

    # A sparse file: the browser sees the full size without writing megabytes to disk.
    def file_of_size(bytes)
      file = Tempfile.new([ "scan", ".png" ])
      file.truncate(bytes)
      @tempfiles << file
      file.path
    end
end
