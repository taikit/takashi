class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :paln_id
      t.datetime :met_at

      t.timestamps null: false
    end
  end
end
