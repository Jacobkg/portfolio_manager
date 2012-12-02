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

  scenario "User adds a bond to a portfolio" do
    #Given a portfolio
    portfolio = Portfolio.new("User")
    id = PortfolioRepository.save(portfolio)

    #When the user adds 10 shares of XYZ stock
    visit "/portfolios/#{id}"
    click_link "Add Asset"
    fill_in "Symbol", :with => "XYZ"
    fill_in "Shares", :with => "10"
    fill_in "Price", :with => "$20.00"
    select "Bond"
    click_button "Add to Portfolio"

    #Then the new shares appear on the portfolio
    within(".bonds") do
      page.should have_content "XYZ"
      page.should have_content "10"
      page.should have_content "$20.00"
    end
  end

  scenario "User edits an asset in the portfolio" do
    #Given a portfolio
    portfolio = Portfolio.new("User").add_stock("XYZ", 10, Money.new(20))
    id = PortfolioRepository.save(portfolio)

    #When the user changes the number of shares of XYZ
    visit "/portfolios/#{id}"
    click_link "Edit"
    fill_in "Shares", :with => "20.5"
    click_button "Save"

    #Then the new shares appear on the portfolio
    page.should have_content "XYZ"
    page.should have_content "20.5"
    page.should have_content "$4.10"
  end

end
