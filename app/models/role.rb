class Role < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_many :users

  paginates_per 10
  
end