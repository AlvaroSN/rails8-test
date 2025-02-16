class User < ApplicationRecord

  validates :email, presence: true, uniqueness: true

  has_one_attached :avatar
  paginates_per 10

  before_create :set_default_role

  belongs_to :role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private
    def set_default_role
      unless role_id
        public_role = Role.find_by(:name => 'public')
        self.role = public_role ? public_role : Role.create(:name => 'public')
      end
    end
end
