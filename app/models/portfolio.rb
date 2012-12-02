class Portfolio
  attr_reader :name, :entries
  def initialize(name, entries = [])
    @name = name
    @entries = entries
  end

  def value
    @entries.inject(Money.new(0)) { |sum, x| sum + x.value }
  end

  def asset(symbol)
    @entries.select {|n| n.symbol == symbol}.first
  end

  def add(symbol, shares, price)
    Portfolio.new(name, @entries + [Asset.new(symbol, shares, price)])
  end

  def update(symbol, shares, price)
    @entry = asset(symbol)
    Portfolio.new(name, @entries - [@entry] + [Asset.new(symbol, shares, price)])
  end

  def update_prices(stock_ticker = StockTicker.new)
    updated_entries = @entries.map { |asset| Asset.new(asset.symbol, asset.shares, stock_ticker.get_price(asset.symbol)) }
    Portfolio.new(@name, updated_entries)
  end

  def ==(other)
    return false unless other.is_a? Portfolio
    self.name == other.name && self.entries == other.entries
  end

end