class ItemsTag

  include ActiveModel::Model
  attr_accessor :tag_name, :name, :description, :category_id, :condition_id, :shipping_charge_id, :prefecture_id, :pays_to_ship_id, :price, :images, :user_id

  with_options presence: true do
    validates :images
    validates :name
    validates :description
    validates :tag_name
  end  

  with_options presence: true, numericality: { other_than: 0 } do
    validates :category_id
    validates :condition_id
    validates :shipping_charge_id
    validates :prefecture_id
    validates :pays_to_ship_id
  end

  validates :price, presence: true, format: { with: /\A[0-9]+\z/ }, length: { minimum: 3, maxinum: 7 }, numericality: { only_integer: true, greater_than: 299, less_than: 10000000 }


  def save
    item = Item.create(name: name, description: description, category_id: category_id, condition_id: condition_id, shipping_charge_id: shipping_charge_id, prefecture_id: prefecture_id, pays_to_ship_id: pays_to_ship_id, price: price, user_id: user_id, images: images)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save

    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

# タグの編集
  # def update
  #   item = Item.update(name: name, description: description, category_id: category_id, condition_id: condition_id, shipping_charge_id: shipping_charge_id, prefecture_id: prefecture_id, pays_to_ship_id: pays_to_ship_id, price: price, user_id: user_id, images: images)
  #   tag = Tag.where(tag_name: tag_name).first_or_initialize
  #   tag.save

  #   ItemTagRelation.update(item_id: item.id, tag_id: tag.id)   
  # end

end