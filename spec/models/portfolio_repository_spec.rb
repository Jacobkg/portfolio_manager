require 'spec_helper'
require 'fake_stock_ticker'


describe PortfolioRepository do

  it "can save and retrieve portfolios by id" do
    susan_portfolio = Portfolio.new("Susan").add_stock("XYZ", 5.2, Money.new(10))
    charles_portfolio = Portfolio.new("Charles").add_bond("ABC", 10, Money.new(5))

    susan_portfolio_id = PortfolioRepository.save(susan_portfolio)
    charles_portfolio_id = PortfolioRepository.save(charles_portfolio)

    PortfolioRepository.load(susan_portfolio_id).should == susan_portfolio
    PortfolioRepository.load(charles_portfolio_id).should == charles_portfolio
  end

  it "updates portfolio if already exists" do
    portfolio = Portfolio.new("My Portfolio")
    first_save_id = PortfolioRepository.save(portfolio)
    second_save_id = PortfolioRepository.save(portfolio.add_stock("ABC", 10, Money.new(5)))
    first_save_id.should == second_save_id
  end

  it "can add assets to existing portfolio" do
    portfolio = Portfolio.new("My Portfolio").add_stock("ABC", 10, Money.new(5))
    PortfolioRepository.save(portfolio)
    updated_portfolio = portfolio.add_stock("XYZ", 25, Money.new(10))
    saved_id = PortfolioRepository.save(updated_portfolio)
    PortfolioRepository.load(saved_id).should == updated_portfolio
  end

  it "can update assets in a portfolio" do
    portfolio = Portfolio.new("My Portfolio").add_stock("ABC", 10, Money.new(5))
    PortfolioRepository.save(portfolio)
    updated_portfolio = portfolio.update_prices(FakeStockTicker.new({"ABC" => Money.new(123)}))
    saved_id = PortfolioRepository.save(updated_portfolio)
    PortfolioRepository.load(saved_id).should == updated_portfolio
  end

end