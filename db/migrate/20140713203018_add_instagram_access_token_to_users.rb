class AddInstagramAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :instagram_access_token, :string
  end
end
