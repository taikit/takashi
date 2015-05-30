class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :user_id
      t.string :image
      t.string :title
      t.text :body
      t.float :amount
      t.integer :area

      t.timestamps null: false
    end
  end
end
