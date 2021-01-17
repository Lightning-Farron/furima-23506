# テーブル設計

## users テーブル

| Column    | Type   | Options     |
| --------  | ------ | ----------- |
| nickname  | string | null: false |
| email     | string | null: false unique: true |
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
| name        | string | null: false |
| description | text   | null: false |
| category_id | integer | null: false |
| condition_id | integer | null: false |
| shipping_charge_id | integer | null: false|
| prefectures_id | integer | null: false |
| pays_to_ship_id | integer | null: false |
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
- has_one :address

## addresses テーブル

| Column    | Type   | Options     |
| --------  | ------ | ----------- |
| postal_code | string | null: false |
| prefectures_id | integer | null: false |
| municipalities | string | null: false |
| address | string | null: false |
| building_name | string |       |
| phone_number | string | null: false |
| buy | references | null: false, foreign_key: true |

- belongs_to :buy