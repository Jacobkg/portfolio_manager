require "spec_helper"

feature "Displaying Portfolio Contents" do

  scenario "Total and Percentage is displayed for each asset in portfolio" do
    #Given a portfolio
    portfolio = Portfolio.new("User").add("AAPL", 10, Money.new(130)).add("GOOG", 25, Money.new(250))
    id = PortfolioRepository.save(portfolio)

    #When the user asks to update prices
    visit "/portfolios/#{id}"

    #Then the totals and percentages should show
    page.should have_content "$13.00"
    page.should have_content "$62.50"

    page.should have_content "17.2%"
    page.should have_content "82.8%"
  end
end