class CreatePortfolioRecords < ActiveRecord::Migration
  def change
    create_table :portfolio_records do |t|
      t.string :name

      t.timestamps
    end
  end
end
