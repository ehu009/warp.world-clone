require "application_system_test_case"

class Warp::LevelsTest < ApplicationSystemTestCase
  setup do
    @warp_level = warp_levels(:one)
  end

  test "visiting the index" do
    visit warp_levels_url
    assert_selector "h1", text: "Warp/Levels"
  end

  test "creating a Level" do
    visit warp_levels_url
    click_on "New Warp/Level"

    click_on "Create Level"

    assert_text "Level was successfully created"
    click_on "Back"
  end

  test "updating a Level" do
    visit warp_levels_url
    click_on "Edit", match: :first

    click_on "Update Level"

    assert_text "Level was successfully updated"
    click_on "Back"
  end

  test "destroying a Level" do
    visit warp_levels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Level was successfully destroyed"
  end
end
