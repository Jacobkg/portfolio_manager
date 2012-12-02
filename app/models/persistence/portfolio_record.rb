class PortfolioRecord < ActiveRecord::Base
  attr_accessible :name

  has_many :assets, :class_name => "AssetRecord"
end
