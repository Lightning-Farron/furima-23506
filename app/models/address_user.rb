class AddressUser < ApplicationRecord

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :prefecture_id, numericality: { other_than: 0}
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/}
    validates :house_number
    validates :phone_number, format: {with: /\A\d{10}\z|\A\d{11}\z/}
  end
  belongs_to :user, optional: true
end
