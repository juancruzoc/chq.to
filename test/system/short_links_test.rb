require "application_system_test_case"

class ShortLinksTest < ApplicationSystemTestCase
  setup do
    @short_link = short_links(:one)
  end

  test "visiting the index" do
    visit short_links_url
    assert_selector "h1", text: "Short links"
  end

  test "should create short link" do
    visit short_links_url
    click_on "New short link"

    fill_in "Expiration date", with: @short_link.expiration_date
    fill_in "Password", with: @short_link.password
    fill_in "Short url", with: @short_link.short_url
    fill_in "Url", with: @short_link.url
    fill_in "Usages", with: @short_link.usages
    fill_in "User", with: @short_link.user_id
    click_on "Create Short link"

    assert_text "Short link was successfully created"
    click_on "Back"
  end

  test "should update Short link" do
    visit short_link_url(@short_link)
    click_on "Edit this short link", match: :first

    fill_in "Expiration date", with: @short_link.expiration_date
    fill_in "Password", with: @short_link.password
    fill_in "Short url", with: @short_link.short_url
    fill_in "Url", with: @short_link.url
    fill_in "Usages", with: @short_link.usages
    fill_in "User", with: @short_link.user_id
    click_on "Update Short link"

    assert_text "Short link was successfully updated"
    click_on "Back"
  end

  test "should destroy Short link" do
    visit short_link_url(@short_link)
    click_on "Destroy this short link", match: :first

    assert_text "Short link was successfully destroyed"
  end
end
