class AddInstagramUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :instagram_user_id, :integer
  end
end
