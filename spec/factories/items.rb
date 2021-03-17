FactoryBot.define do
  factory :item do
    name               {"aaa"}
    description        {"aaaaaaaaaaa"}
    category_id        {1}
    condition_id       {1}
    shipping_charge_id {1}
    prefecture_id     {1}
    pays_to_ship_id    {1}
    price              {11111}
    user_id            {1}
    association :user

    after(:build) do |item|
      item.images.attach(io: File.open('public/images/sample1.png'), filename: 'sample1.png')
    end
  end
end
