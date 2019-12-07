require 'rails_helper'

describe 'visitor visits video show page' do

  it "shows tooltip for visitor not logged-in on hover to tell them they'll need to log in", :js do
    tutorial= create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)
    driver = Selenium::WebDriver.for :chrome

    element = page.driver.browser.find_element(:css, "a#bookmark-btn")
    page.driver.browser.action.move_to(element).perform
    expect(page.find(".tooltip-toggle").visible?).to eq(true)

    expect(page).to have_content("Bookmark")
    expect(page).to_not have_link("Bookmark")
  end
end
