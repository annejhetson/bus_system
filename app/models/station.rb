class Station < ActiveRecord::Base
  has_many :stops
  has_many :lines, through: :stops
  validates :name, presence: true, uniqueness: true
end
