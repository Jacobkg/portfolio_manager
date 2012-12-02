class AssetRecord < ActiveRecord::Base
  attr_accessible :price_in_cents, :shares, :symbol

  belongs_to :portfolio, :class_name => "PortfolioRecord"
end
