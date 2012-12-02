require 'portfolio'
require 'asset'
require 'money'
require 'fake_stock_ticker'

describe Portfolio do

  describe "with no assets" do
    it "has value 0" do
      Portfolio.new("Foo").value.should == Money.new(0)
    end

    it "iterates as empty" do
      Portfolio.new("Foo").to_a.should == []
    end
  end

  it "computes its value from the total of all assets" do
    portfolio = Portfolio.new("Name")
    portfolio = portfolio.add(Asset.new("XYZ", 10, Money.new(150), :stock))
    portfolio = portfolio.add(Asset.new("ABC", 15, Money.new(275), :bond))

    portfolio.value.should == Money.new(5625)
  end

  it "can update the price of its assets from the internet" do
    portfolio = Portfolio.new("Name", [Asset.new("AAPL", 100, Money.new(100), :stock)])
    portfolio.value.should == Money.new(10000)

    fake_stock_ticker = FakeStockTicker.new({"AAPL" => Money.new(58528)})

    updated_portfolio = portfolio.update_prices(fake_stock_ticker)
    updated_portfolio.should_not == portfolio
    updated_portfolio.value.should == Money.new(5852800)
  end

  it "can retrieve asset by symbol" do
    portfolio = Portfolio.new("Name", [Asset.new("AAPL", 100, Money.new(100), :stock),
                                       Asset.new("BAZ", 120, Money.new(50), :stock)])
    portfolio.asset("BAZ").should == Asset.new("BAZ", 120, Money.new(50), :stock)
  end

  it "can update an asset" do
    portfolio = Portfolio.new("Name", [Asset.new("AAPL", 100, Money.new(100), :stock)])
    portfolio = portfolio.update("AAPL", 120, Money.new(500))
    portfolio.value.should == Money.new(60000)
  end

  it "can add a bond" do
    portfolio = Portfolio.new("Name").add(Asset.new("ABC", 10, Money.new(20), :bond))
    portfolio.asset("ABC").asset_class.should == :bond
  end

  it "can add a stock" do
    portfolio = Portfolio.new("Name").add(Asset.new("ABC", 10, Money.new(20), :stock))
    portfolio.asset("ABC").asset_class.should == :stock
  end

  it "can retrieve by stocks and bonds" do
    portfolio = Portfolio.new("Name", [Asset.new("ABC", 10, Money.new(10), :stock),
                                       Asset.new("XYZ", 10, Money.new(10), :bond),
                                       Asset.new("IOU", 20, Money.new(8), :stock)])
    portfolio.assets_of_type(:stock).map(&:symbol).should == ["ABC", "IOU"]
    portfolio.assets_of_type(:bond).map(&:symbol).should == ["XYZ"]
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