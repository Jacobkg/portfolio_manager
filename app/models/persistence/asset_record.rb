class AssetRecord < ActiveRecord::Base
  attr_accessible :price_in_cents, :shares, :symbol, :asset_class

  validates :price_in_cents, numericality: { greater_than: 0 }

  belongs_to :portfolio, :class_name => "PortfolioRecord"
end
