require 'stock_quote'

class StockTicker

  def get_price(symbol)
    Money.new(StockQuote::Stock.quote(symbol).last * 100)
  end

end