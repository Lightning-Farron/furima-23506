class Item < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_one :order
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :pays_to_ship
  has_many :item_tag_relations, dependent: :destroy
  has_many :tags, through: :item_tag_relations
end