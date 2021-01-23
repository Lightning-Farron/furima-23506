FactoryBot.define do
  factory :user do
    nickname              {Faker::Name}
    email                 {Faker::Internet.email}
    password              {"1a" + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    last_name             {"山田"}
    first_name            {"太郎"}
    last_name_reading     {"ヤマダ"}
    first_name_reading    {"タロウ"}
    birthday              {"2011-03-21"}
  end
end


