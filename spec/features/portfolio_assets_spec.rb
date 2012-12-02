require "spec_helper"

feature "Changing the asset makeup of a Portfolio" do

  scenario "User adds an asset to a portfolio" do
    #Given a portfolio
    portfolio = Portfolio.new("User")
    id = PortfolioRepository.save(portfolio)

    #When the user adds 10 shares of XYZ stock
    visit "/portfolios/#{id}"
    click_link "Add Asset"
    fill_in "Symbol", :with => "XYZ"
    fill_in "Shares", :with => "10"
    fill_in "Price", :with => "$20.00"
    click_button "Add to Portfolio"

    #Then the new shares appear on the portfolio
    page.should have_content "XYZ"
    page.should have_content "10"
    page.should have_content "$20.00"
  end

  scenario "User edits an asset in the portfolio" do
    #Given a portfolio
    portfolio = Portfolio.new("User").add("XYZ", 10, Money.new(20))
    id = PortfolioRepository.save(portfolio)

    #When the user changes the number of shares of XYZ
    visit "/portfolios/#{id}"
    click_link "Edit"
    fill_in "Shares", :with => "20"
    click_button "Save"

    #Then the new shares appear on the portfolio
    page.should have_content "XYZ"
    page.should have_content "20"
    page.should have_content "$4.00"
  end

end