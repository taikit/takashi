class AddtokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_column :users,:facebook_url, :string
  end
end
