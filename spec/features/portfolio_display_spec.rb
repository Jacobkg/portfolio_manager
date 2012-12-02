require "spec_helper"

feature "Displaying Portfolio Contents" do

  scenario "Total and Percentage is displayed for each asset in portfolio" do
    #Given a portfolio
    portfolio = Portfolio.new("User", [Asset.new("AAPL", 10, Money.new(130), :stock), Asset.new("GOOG", 25, Money.new(250), :stock)])
    id = PortfolioRepository.save(portfolio)

    #When the user asks to update prices
    visit "/portfolios/#{id}"

    #Then the totals and percentages should show
    page.should have_content "$13.00"
    page.should have_content "$62.50"

    page.should have_content "17.2%"
    page.should have_content "82.8%"
  end

  scenario "Assets seperated into Stocks, Bonds, and Cash with Percentages" do
    #Given a portfolio with stocks and bonds
    portfolio = Portfolio.new("User", [Asset.new("AAPL", 10, Money.new(130), :stock), #$13
                                       Asset.new("GOOG", 5, Money.new(250), :stock), #$12.5
                                       Asset.new("ING Direct", 1.3, Money.new(100), :cash), #$1.3
                                       Asset.new("VFIUX", 12, Money.new(10), :bond), #$1.20
                                       Asset.new("VCADX", 6, Money.new(18), :bond)]) #$1.08
    id = PortfolioRepository.save(portfolio) # Total is $29.08

    visit "/portfolios/#{id}"

    within(".stocks") do
      page.should have_content "Stocks (87.7%)"
      page.should have_content "AAPL"
      page.should have_content "GOOG"
    end

    within(".bonds") do
      page.should have_content "Bonds (7.8%)"
      page.should have_content "VFIUX"
      page.should have_content "VCADX"
    end

    within(".cash") do
      page.should have_content "Cash (4.5%)"
      page.should have_content "ING Direct"
    end
  end
end