class Asset

  CLASSES = [:stock, :bond, :cash]

  attr_reader :symbol, :shares, :price, :asset_class

  def initialize(symbol, shares, price, asset_class)
    @symbol = symbol
    @shares = shares.round(3)
    @price = price
    @asset_class = asset_class
  end

  def value
    price * shares
  end

  def ==(other)
    return false unless other.is_a? Asset
    symbol == other.symbol && shares = other.shares && price == other.price && asset_class == other.asset_class
  end

end