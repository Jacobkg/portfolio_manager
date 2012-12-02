class ChangeAssetSharesToDecimal < ActiveRecord::Migration
  def change
    change_column :asset_records, :shares, :decimal
  end
end
