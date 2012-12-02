class Portfolio
  include Enumerable

  attr_reader :name, :entries
  def initialize(name, entries = [])
    @name = name
    @entries = entries
  end

  def each
    @entries.each do |entry|
      yield entry
    end
  end

  def value
    @entries.inject(Money.new(0)) { |sum, x| sum + x.value }
  end

  def asset(symbol)
    @entries.select {|n| n.symbol == symbol}.first
  end

  def bonds
    Portfolio.new("#{@name} - Bonds", @entries.select {|n| n.asset_class == :bond })
  end

  def stocks
    Portfolio.new("#{@name} - Stocks", @entries.select {|n| n.asset_class == :stock })
  end

  def add(symbol, shares, price)
    Portfolio.new(name, @entries + [Asset.new(symbol, shares, price)])
  end

  def add_bond(symbol, shares, price)
    Portfolio.new(name, @entries + [Asset.bond(symbol, shares, price)])
  end

  def add_stock(symbol, shares, price)
    Portfolio.new(name, @entries + [Asset.stock(symbol, shares, price)])
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