class Candidate < ApplicationRecord
  has_many :votes
  has_many :campaigns, through: :votes
  validates :name, presence: true, uniqueness: true
end
