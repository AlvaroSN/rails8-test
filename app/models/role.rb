class Role < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_many :users

  def self.ransackable_associations(auth_object = nil)
    ["users"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  paginates_per 10
  
end