require "application_system_test_case"

class RoostersTest < ApplicationSystemTestCase
  setup do
    @rooster = roosters(:one)
  end

  test "visiting the index" do
    visit roosters_url
    assert_selector "h1", text: "Roosters"
  end

  test "should create rooster" do
    visit roosters_url
    click_on "New rooster"

    fill_in "Jersey number", with: @rooster.jersey_number
    fill_in "Name", with: @rooster.name
    click_on "Create Rooster"

    assert_text "Rooster was successfully created"
    click_on "Back"
  end

  test "should update Rooster" do
    visit rooster_url(@rooster)
    click_on "Edit this rooster", match: :first

    fill_in "Jersey number", with: @rooster.jersey_number
    fill_in "Name", with: @rooster.name
    click_on "Update Rooster"

    assert_text "Rooster was successfully updated"
    click_on "Back"
  end

  test "should destroy Rooster" do
    visit rooster_url(@rooster)
    click_on "Destroy this rooster", match: :first

    assert_text "Rooster was successfully destroyed"
  end
end
