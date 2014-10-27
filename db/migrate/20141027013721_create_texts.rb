class CreateTexts < ActiveRecord::Migration
  def self.up
    create_table :texts do |t|
      t.integer :text_id, :null => false
      t.string :sent_received, :null => false
      t.datetime :timestamp, :null => false
      t.string :contacts
      t.string :numbers, :null => false
      t.text :message, :null => false
    end

    add_index :texts, :text_id
  end

  def self.down
    drop_table :texts
  end
end
