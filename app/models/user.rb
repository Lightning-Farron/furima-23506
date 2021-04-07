class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :nickname
    validates :birthday
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ } do
    validates :first_name
    validates :last_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/ } do
    validates :first_name_reading
    validates :last_name_reading
  end

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[\w-]{6,128}+\z/i }

  has_one :address_user
end
