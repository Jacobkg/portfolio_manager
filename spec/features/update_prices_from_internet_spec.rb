require "spec_helper"

feature "Updating Portfolio prices from iternet" do

  scenario "User asks to update prices" do
    #Given a portfolio
    portfolio = Portfolio.new("User").add("AAPL", 10, Money.new(100)).add("GOOG", 25, Money.new(250))
    id = PortfolioRepository.save(portfolio)

    #When the user asks to update prices
    visit "/portfolios/#{id}"
    click_on "Update Prices"

    #Then the prices should be updated
    page.should have_content "$585.28"
    page.should have_content "$698.37"
  end

end