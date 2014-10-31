class Text < ActiveRecord::Base
  attr_accessible :sent_received, :timestamp, :contacts, :numbers, :message
  belongs_to :user
end
