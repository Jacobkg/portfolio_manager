class PortfolioRepository

  def self.save(portfolio)
    existing_portfolio = PortfolioRecord.find_by_name(portfolio.name)
    record = existing_portfolio || PortfolioRecord.create!(:name => portfolio.name)
    portfolio.entries.each do |entry|
      unless record.assets.find_by_symbol(entry.symbol)
        record.assets.create! :symbol => entry.symbol, :shares => entry.shares, :price_in_cents => entry.price.cents
      end
    end
    record.id
  end

  def self.load(id)
    record = PortfolioRecord.find(id)
    Portfolio.new(record.name, record.assets.map {|asset| Asset.new(asset.symbol, asset.shares, Money.new(asset.price_in_cents))})
  end
end