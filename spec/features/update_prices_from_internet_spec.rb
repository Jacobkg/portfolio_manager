require "spec_helper"

feature "Updating Portfolio prices from iternet" do

  scenario "User asks to update prices" do
    VCR.use_cassette('Internet Stock Quotes') do
      #Given a portfolio
      portfolio = Portfolio.new("User", [Asset.new("AAPL", 10, Money.new(100), :stock),
                                         Asset.new("GOOG", 25, Money.new(250), :stock),
                                         Asset.new("Cash Reserves", 100, Money.new(100), :cash)])
      id = PortfolioRepository.save(portfolio)

      #When the user asks to update prices
      visit "/portfolios/#{id}"
      click_on "Update Prices"

      #Then the prices for stocks should be updated
      page.should have_content "$585.28"
      page.should have_content "$698.37"

      #And the cash should be left alone
      page.should have_content "$100.00"
    end
  end
end