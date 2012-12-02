describe Asset do

  it "computes value from number of shares and price" do
    stock = Asset.new("ABC", 123, Money.new(150), :stock)
    stock.value.should == Money.new(150) * 123
  end

end