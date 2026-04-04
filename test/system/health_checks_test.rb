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
    assert_selector "h1", text: "Annual Health Check-up Report"
  end

  test "should create health check" do
    sign_in_as @user
    visit pet_health_checks_url(locale: I18n.default_locale, pet_id: @pet.id)
    click_on "Add new report"

    fill_in "ALB(g/dL)", with: @health_check.alb
    fill_in "ALKP(U/L)", with: @health_check.alkp
    fill_in "ALT(U/L)", with: @health_check.alt
    fill_in "AMYL(U/L)", with: @health_check.amyl
    fill_in "BASO(K/µL)", with: @health_check.baso
    fill_in "BUN(mg/dL)", with: @health_check.bun
    fill_in "CA(mg/dL)", with: @health_check.ca
    fill_in "CHOL(mg/dL)", with: @health_check.chol
    fill_in "Cl(mmol/L)", with: @health_check.cl
    fill_in "CREA(mg/dL)", with: @health_check.crea
    fill_in "EOS(K/µL)", with: @health_check.eos
    fill_in "GGT(U/L)", with: @health_check.ggt
    fill_in "GLU(mg/dL)", with: @health_check.glu
    fill_in "HCT(%)", with: @health_check.hct
    fill_in "HGB(g/dL)", with: @health_check.hgb
    fill_in "K(mmol/L)", with: @health_check.k
    fill_in "LIPA(U/L)", with: @health_check.lipa
    fill_in "LYM(K/µL)", with: @health_check.lym
    fill_in "MCH(pg)", with: @health_check.mch
    fill_in "MCHC(g/dL)", with: @health_check.mchc
    fill_in "MCV(fL)", with: @health_check.mcv
    fill_in "MONO(K/µL)", with: @health_check.mono
    fill_in "MPV(fL)", with: @health_check.mpv
    fill_in "Na(mmol/L)", with: @health_check.na
    fill_in "NEU(K/µL)", with: @health_check.neu
    fill_in "Osm Calc(mmol/kg)", with: @health_check.osm_cal
    fill_in "PCT(%)", with: @health_check.pct

    fill_in "PHOS(mg/dL)", with: @health_check.phos
    fill_in "PLT(K/µL)", with: @health_check.plt
    fill_in "RBC(M/µl)", with: @health_check.rbc
    fill_in "RDW(%)", with: @health_check.rdw
    fill_in "RETIC(K/µL)", with: @health_check.retic
    fill_in "RETIC-HGB(pg)", with: @health_check.retic_hgb
    fill_in "TBIL(mg/dL)", with: @health_check.tbil
    fill_in "TP(g/dL)", with: @health_check.tp
    fill_in "WBC(K/µL)", with: @health_check.wbc
    click_on "Add new report"

    assert_text "Health check was successfully created"
  end

  test "should update Health check" do
    sign_in_as @user
    visit pet_health_checks_url(locale: I18n.default_locale, pet_id: @pet.id)
    find("div[data-target='all']").click
    assert_selector "#edit_health_check_#{@health_check.id}"
    find("#edit_health_check_#{@health_check.id}").click

    fill_in "ALB(g/dL)", with: @health_check.alb
    fill_in "ALKP(U/L)", with: @health_check.alkp
    fill_in "ALT(U/L)", with: @health_check.alt
    fill_in "AMYL(U/L)", with: @health_check.amyl
    fill_in "BASO(K/µL)", with: @health_check.baso
    fill_in "BUN(mg/dL)", with: @health_check.bun
    fill_in "CA(mg/dL)", with: @health_check.ca
    fill_in "CHOL(mg/dL)", with: @health_check.chol
    fill_in "Cl(mmol/L)", with: @health_check.cl
    fill_in "CREA(mg/dL)", with: @health_check.crea
    fill_in "EOS(K/µL)", with: @health_check.eos
    fill_in "GGT(U/L)", with: @health_check.ggt
    fill_in "GLU(mg/dL)", with: @health_check.glu
    fill_in "HCT(%)", with: @health_check.hct
    fill_in "HGB(g/dL)", with: @health_check.hgb
    fill_in "K(mmol/L)", with: @health_check.k
    fill_in "LIPA(U/L)", with: @health_check.lipa
    fill_in "LYM(K/µL)", with: @health_check.lym
    fill_in "MCH(pg)", with: @health_check.mch
    fill_in "MCHC(g/dL)", with: @health_check.mchc
    fill_in "MCV(fL)", with: @health_check.mcv
    fill_in "MONO(K/µL)", with: @health_check.mono
    fill_in "MPV(fL)", with: @health_check.mpv
    fill_in "Na(mmol/L)", with: @health_check.na
    fill_in "NEU(K/µL)", with: @health_check.neu
    fill_in "Osm Calc(mmol/kg)", with: @health_check.osm_cal
    fill_in "PCT(%)", with: @health_check.pct

    fill_in "PHOS(mg/dL)", with: @health_check.phos
    fill_in "PLT(K/µL)", with: @health_check.plt
    fill_in "RBC(M/µl)", with: @health_check.rbc
    fill_in "RDW(%)", with: @health_check.rdw
    fill_in "RETIC(K/µL)", with: @health_check.retic
    fill_in "RETIC-HGB(pg)", with: @health_check.retic_hgb
    fill_in "TBIL(mg/dL)", with: @health_check.tbil
    fill_in "TP(g/dL)", with: @health_check.tp
    fill_in "WBC(K/µL)", with: @health_check.wbc
    click_on "Update Health check"

    assert_text "Health check was successfully updated"
  end

  # test "should destroy Health check" do
  #   sign_in_as @user
  #   visit pet_health_check_url(locale: I18n.default_locale, pet_id: @pet.id)
  #   click_on "Destroy this health check", match: :first

  #   assert_text "Health check was successfully destroyed"
  # end
end
