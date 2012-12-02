Asset = Struct.new(:symbol, :shares, :price) do
  def value
    price * shares
  end
end