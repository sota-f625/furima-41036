class Purchase < ApplicationRecord
  attr_accessor :token
  belongs_to :user
  belongs_to :item

  validates :token, presence: true
end
