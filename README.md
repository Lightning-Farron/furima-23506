# テーブル設計

## users テーブル

| Column    | Type   | Options     |
| --------  | ------ | ----------- |
| nickname  | string | null: false |
| email     | string | null: false |
| encrypted_password  | string | null: false |
| last_name  | string | null: false |
| first_name | string | null: false |
| last_name_reading  | string | null: false |
| first_name_reading | string | null: false |
| birthday | date | null: false |
### Association

- has many :items
- has many :buys

## items テーブル

| Column      | Type   | Options     |
| ------      | ------ | ----------- |
| item_name    | string | null: false |
| description | text   | null: false |
| category    | string | null: false |
| condition   | string | null: false |
| shipping_charge | string | null: false|
| shipping_area | string | null: false |
| pays_to_ship | string | null: false |
| price       | integer | nill: false |
| user        | references | null: false, foreign_key: true |
### Association

- belongs_to :user
- has_one :buy

## buys テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |
### Association

- belongs_to :item
- belongs_to :user

## addresses テーブル

| Column    | Type   | Options     |
| --------  | ------ | ----------- |
| credit_number | integer | null: false |
| expiration    | integer | null: false |
| security_number | integer | null: false |
| postal_code | integer | null: false |
| prefectures | string | null: false |
| municipalities | string | null: false |
| address | string | null: false |
| building_name | string | null: false |
| phone_number | integer | null: false |
| buy | references | null: false, foreign_key: true |

- has_one :buy
- belongs_to :address