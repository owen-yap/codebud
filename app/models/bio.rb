class Bio < ApplicationRecord
  belongs_to :user
  after_initialize :init

  def init
    self.content = ""
  end
end
