# テーブル設計

## users テーブル

| Column    | Type   | Options     |
| --------  | ------ | ----------- |
| nickname  | string | null: false |
| email     | string | null: false |
| password  | string | null: false |
| last_name  | string | null: false |
| first_name | string | null: false |
| name_reading | string | null: false |
### Association

- has many :items
- has many :buys

## items テーブル

| Column      | Type   | Options     |
| ------      | ------ | ----------- |
| item_name    | string | null: false |
| description | text   | null: false |
| price       | integer | nill: false |
| user        | references | null: false, foreign_key: true |
### Association

- belongs_to :user
- has_one :buy

## buys テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user