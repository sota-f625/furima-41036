# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birth_day          | date    | null: false               |

### Association
- has_many :items
- has_many :purchases
- has_many :comments
- has_many :likes

## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| description        | text       | null: false                    |
| category_id        | references | null: false                    |
| condition_id       | references | null: false                    |
| shipping_fee_id    | references | null: false                    |
| purchase_id        | references | null: false                    |
| shipping_day_id    | references | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :comments
- has_many :likes
- has_one :purchase

## purchases テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| prefecture_id | references | null: false foreign_key: true  |
| city          | string     | null: false                    |
| address       | integer    | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| purchase      | references | null: false                    |

### Association
- belongs_to :purchase

## comments テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |
| text   | text       | null: false                    |

### Association
- belongs_to :user
- belongs_to :item

## likes テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

## categories テーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| category   | string | null: false |

### Association
- has_many :items

## conditions テーブル

| Column      | Type   | Options     |
| ----------- | ------ | ----------- |
| condition   | string | null: false |

### Association
- has_many :items

## shipping_fees テーブル

| Column       | Type   | Options     |
| ------------ | ------ | ----------- |
| shipping_fee | string | null: false |

### Association
- has_many :items

## purchases テーブル

| Column        | Type   | Options     |
| ------------- | ------ | ----------- |
| purchase      | string | null: false |

### Association
- has_many :items

## shipping_days テーブル

| Column       | Type   | Options     |
| ------------ | ------ | ----------- |
| shipping_day | string | null: false |

### Association
- has_many :items
