class RemoveTextId < ActiveRecord::Migration
  def up
    remove_column :texts, :text_id
  end

  def down
    add_column :texts, :text_id
  end
end
