require "spec_helper"

feature "Displaying Portfolio Contents" do

  scenario "Total and Percentage is displayed for each asset in portfolio" do
    #Given a portfolio
    portfolio = Portfolio.new("User").add_stock("AAPL", 10, Money.new(130)).add_stock("GOOG", 25, Money.new(250))
    id = PortfolioRepository.save(portfolio)

    #When the user asks to update prices
    visit "/portfolios/#{id}"

    #Then the totals and percentages should show
    page.should have_content "$13.00"
    page.should have_content "$62.50"

    page.should have_content "17.2%"
    page.should have_content "82.8%"
  end

  scenario "Assets seperated into Stocks and Bonds with Percentages" do
    #Given a portfolio with stocks and bonds
    portfolio = Portfolio.new("User").add_stock("AAPL", 10, Money.new(130)) #$13
                                     .add_stock("GOOG", 5, Money.new(250)) #$12.5
                                     .add_bond("VFIUX", 12, Money.new(10)) #$1.20
                                     .add_bond("VCADX", 6, Money.new(18)) #$1.08
    id = PortfolioRepository.save(portfolio) # Total is $27.78

    visit "/portfolios/#{id}"

    within(".stocks") do
      page.should have_content "Stocks (91.8%)"
      page.should have_content "AAPL"
      page.should have_content "GOOG"
    end

    within(".bonds") do
      page.should have_content "Bonds (8.2%)"
      page.should have_content "VFIUX"
      page.should have_content "VCADX"
    end
  end
end