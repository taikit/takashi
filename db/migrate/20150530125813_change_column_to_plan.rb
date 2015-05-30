class ChangeColumnToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :category_id, :integer
    rename_column :plans, :area, :area_id
  end
end
