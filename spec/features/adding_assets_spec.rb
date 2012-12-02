require "spec_helper"

feature "Adding assets to a portfolio" do

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

end