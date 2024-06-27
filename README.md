# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | NULL: false               |
| email              | string  | NULL: false, unique: true |
| encrypted_password | string  | NULL: false               |
| last_name          | string  | NULL: false               |
| first_name         | string  | NULL: false               |
| last_name_kana     | string  | NULL: false               |
| first_name_kana    | string  | NULL: false               |
| birth_day_yy       | integer | NULL: false               |
| birth_day_mm       | integer | NULL: false               |
| birth_day_dd       | integer | NULL: false               |

### Association
- has_many :items
- has_many :purchases
- has_many :comments
- has_many :likes

## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | NULL: false                    |
| description        | text       | NULL: false                    |
| category_id        | references | NULL: false, foreign_key: true |
| condition_id       | references | NULL: false, foreign_key: true |
| shipping_fee_id    | references | NULL: false, foreign_key: true |
| purchase_id        | references | NULL: false, foreign_key: true |
| shipping_days_id   | references | NULL: false, foreign_key: true |
| price              | integer    | NULL: false                    |
| user_id            | references | NULL: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :comments
- has_many :likes
- has_one :purchase
- belongs_to :category
- belongs_to :condition
- belongs_to :shipping_fee
- belongs_to :purchase
- belongs_to :shipping_days

## purchases テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | NULL: false, foreign_key: true |
| item_id | references | NULL: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## address テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | integer    | NULL: false                    |
| prefecture_id | references | NULL: false foreign_key: true  |
| city          | string     | NULL: false                    |
| addresses     | integer    | NULL: false                    |
| building_name | string     |                                |
| phone_number  | integer    | NULL: false                    |
| purchase      | references | NULL: false, foreign_key: true |

### Association
- belongs_to :purchase

## comments テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | NULL: false                    |
| user   | references | NULL: false, foreign_key: true |
| item   | references | NULL: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

## likes テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | NULL: false, foreign_key: true |
| item   | references | NULL: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

## categories テーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| category   | string | NULL: false |

### Association
- has_many :items

## conditions テーブル

| Column      | Type   | Options     |
| ----------- | ------ | ----------- |
| condition   | string | NULL: false |

### Association
- has_many :items

## shipping_fees テーブル

| Column       | Type   | Options     |
| ------------ | ------ | ----------- |
| shipping_fee | string | NULL: false |

### Association
- has_many :items

## purchases テーブル

| Column        | Type   | Options     |
| ------------- | ------ | ----------- |
| purchase      | string | NULL: false |

### Association
- has_many :items

## shipping_days テーブル

| Column       | Type   | Options     |
| ------------ | ------ | ----------- |
| shipping_day | string | NULL: false |

### Association
- has_many :items
