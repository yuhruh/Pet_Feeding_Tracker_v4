require "test_helper"

class HealthChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pet = pets(:one)
    @health_check = health_checks(:one)
    @user = User.create(email_address: "example@email.com", password: "password", password_confirmation: "password", username: "John Doe", timezone: "Asia/Taipei")
    post session_url, params: { email_address: @user.email_address, password: "password" }
    # log_in_as(users(:one))
  end

  test "should get index" do
    get pet_health_checks_url(@pet)
    assert_response :success
  end

  test "should get new" do
    get new_pet_health_check_url(@pet)
    assert_response :success
  end

  test "should create health_check" do
    assert_difference("HealthCheck.count") do
      post pet_health_checks_url(@pet), params: { health_check: { alb: @health_check.alb, alkp: @health_check.alkp, alt: @health_check.alt, amyl: @health_check.amyl, baso: @health_check.baso, bun: @health_check.bun, ca: @health_check.ca, chol: @health_check.chol, cl: @health_check.cl, crea: @health_check.crea, eos: @health_check.eos, ggt: @health_check.ggt, glu: @health_check.glu, hct: @health_check.hct, hgb: @health_check.hgb, k: @health_check.k, lipa: @health_check.lipa, lym: @health_check.lym, mch: @health_check.mch, mchc: @health_check.mchc, mcv: @health_check.mcv, mono: @health_check.mono, mpv: @health_check.mpv, na: @health_check.na, neu: @health_check.neu, osm_cal: @health_check.osm_cal, pct: @health_check.pct, pet_id: @health_check.pet_id, phos: @health_check.phos, plt: @health_check.plt, rbc: @health_check.rbc, rdw: @health_check.rdw, retic: @health_check.retic, retic_hgb: @health_check.retic_hgb, tbil: @health_check.tbil, tp: @health_check.tp, wbc: @health_check.wbc } }
    end

    assert_redirected_to pet_health_checks_url(@pet, locale: I18n.default_locale)
  end

  # test "should show health_check" do
  #   get pet_health_check_url(@pet, @health_check)
  #   assert_response :success
  # end

  test "should get edit" do
    get edit_pet_health_check_url(@pet, @health_check)
    assert_response :success
  end

  test "should update health_check" do
    patch pet_health_check_url(@pet, @health_check), params: { health_check: { alb: @health_check.alb, alkp: @health_check.alkp, alt: @health_check.alt, amyl: @health_check.amyl, baso: @health_check.baso, bun: @health_check.bun, ca: @health_check.ca, chol: @health_check.chol, cl: @health_check.cl, crea: @health_check.crea, eos: @health_check.eos, ggt: @health_check.ggt, glu: @health_check.glu, hct: @health_check.hct, hgb: @health_check.hgb, k: @health_check.k, lipa: @health_check.lipa, lym: @health_check.lym, mch: @health_check.mch, mchc: @health_check.mchc, mcv: @health_check.mcv, mono: @health_check.mono, mpv: @health_check.mpv, na: @health_check.na, neu: @health_check.neu, osm_cal: @health_check.osm_cal, pct: @health_check.pct, pet_id: @health_check.pet_id, phos: @health_check.phos, plt: @health_check.plt, rbc: @health_check.rbc, rdw: @health_check.rdw, retic: @health_check.retic, retic_hgb: @health_check.retic_hgb, tbil: @health_check.tbil, tp: @health_check.tp, wbc: @health_check.wbc } }
    assert_redirected_to pet_health_checks_url(@pet, locale: I18n.default_locale)
  end

  test "should destroy health_check" do
    assert_difference("HealthCheck.count", -1) do
      delete pet_health_check_url(@pet, @health_check)
    end

    assert_redirected_to pet_health_checks_url(locale: I18n.default_locale)
  end
end
