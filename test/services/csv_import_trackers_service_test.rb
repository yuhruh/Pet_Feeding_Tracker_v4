require "test_helper"

class CsvImportTrackersServiceTest < ActiveSupport::TestCase
  setup do
    @pet = pets(:one)
    @user = users(:one)
    @service = CsvImportTrackersService.new(@pet, @user)
  end

  test "should import CSV with localized headers (reproducibility of the issue)" do
    csv_content = <<~CSV
      Date;Feed Time;Come Back to Eat;Food Type;Brand;Description;Amount(g);Left Amount(g);Total Ate Amount(g);Hungry;Love;Result;Note;Weight(kg)
      2026-04-26;10:00;-;Wet;Brand A;Description A;100;20;80;💖 Yes, eat right away;💕 Love it So Much;💖 - 💕;Some note;5.5
    CSV

    file = Tempfile.new(["trackers", ".csv"])
    file.write(csv_content)
    file.rewind

    assert_difference "@pet.trackers.count", 1 do
      result = @service.call(file.path)
      assert result, "Import should be successful. Errors: #{@service.errors.join(", ")}"
    end
  ensure
    file.close
    file.unlink
  end

  test "should import CSV with internal names (fixture style)" do
    csv_content = <<~CSV
      date;feed_time;come_back_to_eat;food_type;brand;description;amount;left_amount;hungry;love;note;weight
      2026-04-26;10:00;-;Wet;Brand B;Description B;100;20;💖 Yes, eat right away;💕 Love it So Much;Some note;5.5
    CSV

    file = Tempfile.new(["trackers", ".csv"])
    file.write(csv_content)
    file.rewind

    assert_difference "@pet.trackers.count", 1 do
      result = @service.call(file.path)
      assert result, "Import should be successful. Errors: #{@service.errors.join(", ")}"
    end
  ensure
    file.close
    file.unlink
  end

  test "should import CSV with Chinese localized headers and values" do
    # Simulate Chinese locale
    I18n.with_locale(:"zh-TW") do
      csv_content = <<~CSV
        日期;餵食時間;回頭吃;食物類型;品牌;描述;量(克);剩餘量(克);總共食用量(克);飢餓狀態;喜愛程度;結果;備註;體重(公斤)
        2026-04-26;10:00;-;濕食;品牌A;描述A;100;20;80;💖 是，很餓，馬上吃;💕 非常喜歡;💖 - 💕;一些筆記;5.5
      CSV
      
      file = Tempfile.new(["trackers_zh", ".csv"])
      file.write(csv_content)
      file.rewind

      assert_difference "@pet.trackers.count", 1 do
        result = @service.call(file.path)
        assert result, "Import should be successful for Chinese. Errors: #{@service.errors.join(", ")}"
      end
      
      tracker = @pet.trackers.last
      assert_equal "wet", tracker.food_type
      assert_equal "eat_right_away", tracker.hungry
    ensure
      file.close
      file.unlink
    end
  end
end
