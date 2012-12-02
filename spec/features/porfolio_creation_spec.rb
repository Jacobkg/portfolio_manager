require "spec_helper"

feature "Creating a Portfolio" do

  scenario "User creates a new portfolio" do
    visit "/portfolios/new"

    fill_in "Name", :with => "Jacob's Portfolio"
    click_button "Create Portfolio"

    page.should have_text("Jacob's Portfolio")
  end

end