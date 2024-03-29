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

  def assets_of_type(asset_class)
    Portfolio.new("#{@name} - #{asset_class}", @entries.select {|n| n.asset_class == asset_class })
  end

  def add(asset)
    Portfolio.new(name, @entries + [asset])
  end

  def update(symbol, shares, price)
    @entry = asset(symbol)
    Portfolio.new(name, @entries - [@entry] + [Asset.new(symbol, shares, price, @entry.asset_class)])
  end

  def update_prices(stock_ticker = StockTicker.new)
    updated_entries = []
    @entries.each do |entry|
      updated_price = stock_ticker.get_price(entry.symbol)
      updated_price = entry.price if updated_price == Money.new(0)
      updated_entries << Asset.new(entry.symbol, entry.shares, updated_price, entry.asset_class)
    end
    Portfolio.new(@name, updated_entries)
  end

  def ==(other)
    return false unless other.is_a? Portfolio
    self.name == other.name && self.entries == other.entries
  end

end