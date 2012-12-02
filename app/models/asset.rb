class Asset

  attr_reader :symbol, :shares, :price, :asset_class

  def initialize(symbol, shares, price, asset_class = :stock)
    @symbol = symbol
    @shares = shares
    @price = price
    @asset_class = asset_class
  end

  def self.bond(symbol, shares, price)
    Asset.new(symbol, shares, price, :bond)
  end

  def self.stock(symbol, shares, price)
    Asset.new(symbol, shares, price, :stock)
  end

  def value
    price * shares
  end

  def ==(other)
    return false unless other.is_a? Asset
    symbol == other.symbol && shares = other.shares && price == other.price && asset_class == other.asset_class
  end

end