class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :pays_to_ship

  with_options presence: true do
    validates :image
    validates :name
    validates :description
  end  

  with_options presence: true, numericality: { other_than: 0 } do
    validates :category_id
    validates :condition_id
    validates :shipping_charge_id
    validates :prefecture_id
    validates :pays_to_ship_id
  end

  validates :price, presence: true, format: { with: /\A[0-9]+\z/ }, length: { minimum: 3, maxinum: 7 }, numericality: { only_integer: true, greater_than: 299, less_than: 10000000 }
end