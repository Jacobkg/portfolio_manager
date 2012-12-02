require 'portfolio'
require 'asset'
require 'money'
require 'fake_stock_ticker'

describe Portfolio do

  it "computes its value from the total of all assets" do
    portfolio = Portfolio.new("Name")
    portfolio = portfolio.add("XYZ", 10, Money.new(150))
    portfolio = portfolio.add("ABC", 15, Money.new(275))

    portfolio.value.should == Money.new(5625)
  end

  it "can update the price of its assets from the internet" do
    portfolio = Portfolio.new("Name").add("AAPL", 100, Money.new(100))
    portfolio.value.should == Money.new(10000)

    fake_stock_ticker = FakeStockTicker.new({"AAPL" => Money.new(58528)})

    updated_portfolio = portfolio.update_prices(fake_stock_ticker)
    updated_portfolio.should_not == portfolio
    updated_portfolio.value.should == Money.new(5852800)
  end

end

class FakeStockTicker

  def initialize(prices)
    @prices = prices
  end

  def get_price(symbol)
    return @prices.fetch(symbol)
  end

end