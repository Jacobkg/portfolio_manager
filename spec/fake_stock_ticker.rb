class FakeStockTicker

  def initialize(prices)
    @prices = prices
  end

  def get_price(symbol)
    return @prices.fetch(symbol)
  end

end