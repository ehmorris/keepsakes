class CreateTexts < ActiveRecord::Migration
  def self.up
    create_table :texts do |t|
      t.index :text_id, :null => false
      t.string :sent_received, :null => false
      t.datetime :timestamp, :null => false
      t.string :contacts
      t.string :numbers, :null => false
      t.text :message, :null => false
    end
  end

  def self.down
    drop_table :texts
  end
end
