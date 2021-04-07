FactoryBot.define do
  factory :address_user do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    house_number { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { '11111111111' }
  end
end
