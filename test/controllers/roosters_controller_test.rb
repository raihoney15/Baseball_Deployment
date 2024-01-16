require "test_helper"

class RoostersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rooster = roosters(:one)
  end

  test "should get index" do
    get roosters_url
    assert_response :success
  end

  test "should get new" do
    get new_rooster_url
    assert_response :success
  end

  test "should create rooster" do
    assert_difference("Rooster.count") do
      post roosters_url, params: { rooster: { jersey_number: @rooster.jersey_number, name: @rooster.name } }
    end

    assert_redirected_to rooster_url(Rooster.last)
  end

  test "should show rooster" do
    get rooster_url(@rooster)
    assert_response :success
  end

  test "should get edit" do
    get edit_rooster_url(@rooster)
    assert_response :success
  end

  test "should update rooster" do
    patch rooster_url(@rooster), params: { rooster: { jersey_number: @rooster.jersey_number, name: @rooster.name } }
    assert_redirected_to rooster_url(@rooster)
  end

  test "should destroy rooster" do
    assert_difference("Rooster.count", -1) do
      delete rooster_url(@rooster)
    end

    assert_redirected_to roosters_url
  end
end
