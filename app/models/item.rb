class Item < ApplicationRecord
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_id
  belongs_to :condition_id
  belongs_to :shipping_charge_id
  belongs_to :prefectures_id
  belongs_to :pays_to_ship_id
end