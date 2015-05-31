class ChangeAmountToPlans < ActiveRecord::Migration
  def up
    change_column :Plans, :amount, :integer
  end

  def down
    change_column :Plans, :amount, :float
end
end
