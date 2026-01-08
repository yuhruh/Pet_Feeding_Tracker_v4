require "test_helper"

class DryFoodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dry_food = dry_foods(:one)
  end

  test "should get index" do
    get dry_foods_url
    assert_response :success
  end

  test "should get new" do
    get new_dry_food_url
    assert_response :success
  end

  test "should create dry_food" do
    assert_difference("DryFood.count") do
      post dry_foods_url, params: { dry_food: { user_id: @dry_food.user_id, amount: @dry_food.amount, average_used_amount: @dry_food.average_used_amount, brand: @dry_food.brand, days_remaining: @dry_food.days_remaining, description: @dry_food.description, food_type: @dry_food.food_type, left_amount: @dry_food.left_amount, total_ate_amount: @dry_food.total_ate_amount, used_amount: @dry_food.used_amount } }
    end

    assert_redirected_to dry_food_url(DryFood.last)
  end

  test "should show dry_food" do
    get dry_food_url(@dry_food)
    assert_response :success
  end

  test "should get edit" do
    get edit_dry_food_url(@dry_food)
    assert_response :success
  end

  test "should update dry_food" do
    require "test_helper"

class DryFoodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as(users(:one))
    @dry_food = dry_foods(:one)
    @dry_food.user = users(:one)
  end

  test "should get index" do
    get dry_foods_url
    assert_response :success
  end

  test "should get new" do
    get new_dry_food_url
    assert_response :success
  end

  test "should create dry_food" do
    assert_difference("DryFood.count") do
      post dry_foods_url, params: { dry_food: { user_id: @dry_food.user_id, amount: @dry_food.amount, average_used_amount: @dry_food.average_used_amount, brand: @dry_food.brand, days_remaining: @dry_food.days_remaining, description: @dry_food.description, food_type: @dry_food.food_type, left_amount: @dry_food.left_amount, total_ate_amount: @dry_food.total_ate_amount, used_amount: @dry_food.used_amount } }
    end

    assert_redirected_to dry_food_url(DryFood.last)
  end

  test "should show dry_food" do
    get dry_food_url(@dry_food)
    assert_response :success
  end

  test "should get edit" do
    get edit_dry_food_url(@dry_food)
    assert_response :success
  end

  test "should update dry_food" do
    patch dry_food_url(@dry_food), params: { dry_food: { user_id: @dry_food.user_id, amount: @dry_food.amount, average_used_amount: @dry_food.average_used_amount, brand: @dry_food.brand, days_remaining: @dry_food.days_remaining, description: @dry_food.description, food_type: @dry_food.food_type, left_amount: @dry_food.left_amount, total_ate_amount: @dry_food.total_ate_amount, used_amount: @dry_food.used_amount } }
    assert_redirected_to dry_food_url(@dry_food)
  end

  test "should destroy dry_food" do
    assert_difference("DryFood.count", -1) do
      delete dry_food_url(@dry_food)
    end

    assert_redirected_to dry_foods_url
  end
end

    assert_redirected_to dry_food_url(@dry_food)
  end

  test "should destroy dry_food" do
    assert_difference("DryFood.count", -1) do
      delete dry_food_url(@dry_food)
    end

    assert_redirected_to dry_foods_url
  end
end
