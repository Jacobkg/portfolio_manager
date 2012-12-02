require 'spec_helper'

describe PortfolioRepository do

  it "can save and retrieve portfolios by id" do
    susan_portfolio = Portfolio.new("Susan").add("XYZ", 5, Money.new(10))
    charles_portfolio = Portfolio.new("Charles").add("ABC", 10, Money.new(5))

    susan_portfolio_id = PortfolioRepository.save(susan_portfolio)
    charles_portfolio_id = PortfolioRepository.save(charles_portfolio)

    PortfolioRepository.load(susan_portfolio_id).should == susan_portfolio
    PortfolioRepository.load(charles_portfolio_id).should == charles_portfolio
  end

end