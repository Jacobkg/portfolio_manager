describe Asset do

  it "computes value from number of shares and price" do
    stock = Asset.new("ABC", 123, Money.new(150), :stock)
    stock.value.should == Money.new(150) * 123
  end

  it "truncates asset shares to 3 decimal places" do
    Asset.new("ABC", 123.12365, Money.new(1), :cash).shares.should == 123.124
  end

end