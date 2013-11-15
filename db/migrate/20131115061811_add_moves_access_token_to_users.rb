class AddMovesAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :moves_access_token, :string
  end
end
