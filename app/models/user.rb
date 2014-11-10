class User < ActiveRecord::Base
  include Clearance::User
  has_many :texts

  def connected_instagram?
    self.instagram_access_token.present?
  end

  def connected_moves?
    self.moves_access_token.present?
  end

  def uploaded_texts?
    self.texts.first.present?
  end

  def uploaded_journal?
    true
  end
end
