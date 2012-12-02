describe Asset do

  it "computes value from number of shares and price" do
    stock = Asset.new("ABC", 123, Money.new(150))
    stock.value.should == Money.new(150) * 123
  end

  it "can create a bond" do
    bond = Asset.bond("ABC", 123, Money.new(150))
    bond.asset_class.should == :bond
  end

  it "can create a stock" do
    stock = Asset.stock("XYZ", 987, Money.new(120))
    stock.asset_class.should == :stock
  end

end