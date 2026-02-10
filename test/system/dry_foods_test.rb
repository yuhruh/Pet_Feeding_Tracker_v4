require "application_system_test_case"

class DryFoodsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @dry_food = dry_foods(:one)
    @dry_food.user = users(:one)
  end

  test "visiting the index" do
    sign_in_as @user
    visit dry_foods_url
    assert_selector "h1", text: "Dry Foods Storage List"
  end

  test "should create dry food" do
    sign_in_as @user
    visit dry_foods_url
    click_on "add dry food"

    fill_in "Amount", with: @dry_food.amount
    fill_in "Brand", with: @dry_food.brand
    fill_in "Description", with: @dry_food.description
    select "Freeze-Dried", from: "Food type"
    click_on "Add dry food"

    assert_selector "#alert-message", text: "Dry food was successfully created"
  end

  # test "should update Dry food" do
  #   visit dry_food_url(@dry_food)
  #   click_on "Edit this dry food", match: :first

  #   fill_in "User", with: @dry_food.user_id
  #   fill_in "Amount", with: @dry_food.amount
  #   fill_in "Average used amount", with: @dry_food.average_used_amount
  #   fill_in "Brand", with: @dry_food.brand
  #   fill_in "Days remaining", with: @dry_food.days_remaining
  #   fill_in "Description", with: @dry_food.description
  #   fill_in "Food type", with: @dry_food.food_type
  #   fill_in "Left amount", with: @dry_food.left_amount
  #   fill_in "Total ate amount", with: @dry_food.total_ate_amount
  #   fill_in "Used amount", with: @dry_food.used_amount
  #   click_on "Update Dry food"

  #   assert_text "Dry food was successfully updated"
  #   click_on "Back"
  # end

  test "should destroy Dry food" do
    sign_in_as @user
    visit dry_foods_url
    accept_confirm do
      find("#delete_dry_food_#{@dry_food.id}").click
    end

    assert_text "Dry food was successfully destroyed"
  end
end
