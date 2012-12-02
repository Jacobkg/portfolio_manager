class AddAssetClassToAssetRecord < ActiveRecord::Migration
  def change
    add_column :asset_records, :asset_class, :string
  end
end
