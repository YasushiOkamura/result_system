require "application_system_test_case"

class AtheletesTest < ApplicationSystemTestCase
  setup do
    @athelete = atheletes(:one)
  end

  test "visiting the index" do
    visit atheletes_url
    assert_selector "h1", text: "Atheletes"
  end

  test "creating a Athelete" do
    visit atheletes_url
    click_on "New Athelete"

    click_on "Create Athelete"

    assert_text "Athelete was successfully created"
    click_on "Back"
  end

  test "updating a Athelete" do
    visit atheletes_url
    click_on "Edit", match: :first

    click_on "Update Athelete"

    assert_text "Athelete was successfully updated"
    click_on "Back"
  end

  test "destroying a Athelete" do
    visit atheletes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Athelete was successfully destroyed"
  end
end
