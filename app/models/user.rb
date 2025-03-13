class User < ApplicationRecord
  rolify
  
  validates :email, presence: true, uniqueness: true

  has_one_attached :avatar
  paginates_per 10

  before_create :set_default_role

  has_many :likes, dependent: :destroy
  has_many :liked_products, through: :likes, source: :product

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    has_role?(:admin)
  end

  def public?
    has_role?(:public)
  end

  def self.ransackable_associations(auth_object = nil)
    ["roles"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["email"]
  end

  private

  def set_default_role
    add_role(:public) if roles.blank?
  end
end
