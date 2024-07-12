class Campaign < ApplicationRecord
  has_many :votes
  has_many :candidates, through: :votes
  validates :name, presence: true, uniqueness: true
end
