class CreateAssetRecords < ActiveRecord::Migration
  def change
    create_table :asset_records do |t|
      t.string :symbol
      t.integer :shares
      t.integer :price_in_cents
      t.integer :portfolio_record_id

      t.timestamps
    end
  end
end
