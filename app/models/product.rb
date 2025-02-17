class Product < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at description id image_url name price updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[likes users]
  end
end