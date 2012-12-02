class PortfolioRepository

  def self.save(portfolio)
    record = PortfolioRecord.create! :name => portfolio.name
    portfolio.entries.each do |entry|
      record.assets.create! :symbol => entry.symbol, :shares => entry.shares, :price_in_cents => entry.price.cents
    end
    record.id
  end

  def self.load(id)
    record = PortfolioRecord.find(id)
    Portfolio.new(record.name, record.assets.map {|asset| Asset.new(asset.symbol, asset.shares, Money.new(asset.price_in_cents))})
  end
end