require "application_system_test_case"

class HealthChecksTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @pet = pets(:one)
    @health_check = health_checks(:one)
  end

  test "visiting the index" do
    sign_in_as @user
    visit pet_health_checks_url(locale: I18n.default_locale, pet_id: @pet.id)
    assert_selector "h1", text: "Health checks"
  end

  test "should create health check" do
    sign_in_as @user
    visit pet_health_checks_url(locale: I18n.default_locale, pet_id: @pet.id)
    click_on "New health check"

    fill_in "Alb", with: @health_check.alb
    fill_in "Alkp", with: @health_check.alkp
    fill_in "Alt", with: @health_check.alt
    fill_in "Amyl", with: @health_check.amyl
    fill_in "Baso", with: @health_check.baso
    fill_in "Bun", with: @health_check.bun
    fill_in "Ca", with: @health_check.ca
    fill_in "Chol", with: @health_check.chol
    fill_in "Cl", with: @health_check.cl
    fill_in "Crea", with: @health_check.crea
    fill_in "Eos", with: @health_check.eos
    fill_in "Ggt", with: @health_check.ggt
    fill_in "Glu", with: @health_check.glu
    fill_in "Hct", with: @health_check.hct
    fill_in "Hgb", with: @health_check.hgb
    fill_in "K", with: @health_check.k
    fill_in "Lipa", with: @health_check.lipa
    fill_in "Lym", with: @health_check.lym
    fill_in "Mch", with: @health_check.mch
    fill_in "Mchc", with: @health_check.mchc
    fill_in "Mcv", with: @health_check.mcv
    fill_in "Mono", with: @health_check.mono
    fill_in "Mpv", with: @health_check.mpv
    fill_in "Na", with: @health_check.na
    fill_in "Neu", with: @health_check.neu
    fill_in "Osm-cal", with: @health_check.osm-cal
    fill_in "Pct", with: @health_check.pct
    fill_in "Pets", with: @health_check.pets_id
    fill_in "Phos", with: @health_check.phos
    fill_in "Plt", with: @health_check.plt
    fill_in "Rbc", with: @health_check.rbc
    fill_in "Rdw", with: @health_check.rdw
    fill_in "Retic", with: @health_check.retic
    fill_in "Retic-hgb", with: @health_check.retic-hgb
    fill_in "Tbil", with: @health_check.tbil
    fill_in "Tp", with: @health_check.tp
    fill_in "Wbc", with: @health_check.wbc
    click_on "Create Health check"

    assert_text "Health check was successfully created"
    click_on "Back"
  end

  test "should update Health check" do
    sign_in_as @user
    visit pet_health_checks_url(locale: I18n.default_locale, pet_id: @pet.id)
    click_on "Edit this health check", match: :first

    fill_in "Alb", with: @health_check.alb
    fill_in "Alkp", with: @health_check.alkp
    fill_in "Alt", with: @health_check.alt
    fill_in "Amyl", with: @health_check.amyl
    fill_in "Baso", with: @health_check.baso
    fill_in "Bun", with: @health_check.bun
    fill_in "Ca", with: @health_check.ca
    fill_in "Chol", with: @health_check.chol
    fill_in "Cl", with: @health_check.cl
    fill_in "Crea", with: @health_check.crea
    fill_in "Eos", with: @health_check.eos
    fill_in "Ggt", with: @health_check.ggt
    fill_in "Glu", with: @health_check.glu
    fill_in "Hct", with: @health_check.hct
    fill_in "Hgb", with: @health_check.hgb
    fill_in "K", with: @health_check.k
    fill_in "Lipa", with: @health_check.lipa
    fill_in "Lym", with: @health_check.lym
    fill_in "Mch", with: @health_check.mch
    fill_in "Mchc", with: @health_check.mchc
    fill_in "Mcv", with: @health_check.mcv
    fill_in "Mono", with: @health_check.mono
    fill_in "Mpv", with: @health_check.mpv
    fill_in "Na", with: @health_check.na
    fill_in "Neu", with: @health_check.neu
    fill_in "Osm-cal", with: @health_check.osm-cal
    fill_in "Pct", with: @health_check.pct
    fill_in "Pets", with: @health_check.pets_id
    fill_in "Phos", with: @health_check.phos
    fill_in "Plt", with: @health_check.plt
    fill_in "Rbc", with: @health_check.rbc
    fill_in "Rdw", with: @health_check.rdw
    fill_in "Retic", with: @health_check.retic
    fill_in "Retic-hgb", with: @health_check.retic-hgb
    fill_in "Tbil", with: @health_check.tbil
    fill_in "Tp", with: @health_check.tp
    fill_in "Wbc", with: @health_check.wbc
    click_on "Update Health check"

    assert_text "Health check was successfully updated"
    click_on "Back"
  end

  test "should destroy Health check" do
    sign_in_as @user
    visit pet_health_checks_url(locale: I18n.default_locale, pet_id: @pet.id)
    click_on "Destroy this health check", match: :first

    assert_text "Health check was successfully destroyed"
  end
end
