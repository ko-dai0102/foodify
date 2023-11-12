# Foodify
![d7282fc14153bf7887400c4f8710993e](https://github.com/ko-dai0102/foodify/assets/104829293/f5ebb139-4676-4f61-96a2-257fcab1e902)
Foodifyとは画像を投稿できるWebアプリケーションです。

![66d67fb24392d7afe1d1dad881bffd94](https://github.com/ko-dai0102/foodify/assets/104829293/54949283-6367-4e08-9f43-60ac76d6ae03)
投稿時に設定されたカテゴリーやタグによって絞ることができます。



## URL
https://foodify-mwxq.onrender.com/

# テーブル設計

## Users テーブル

| Column             | Type       | Options                   |
| ------------------ | ---------- | ------------------------- |
| name               | string     | null: false               |
| email              | string     | null: false, unique: true |
| encrypted_password | string     | null: false               |

### Association

- has_many :items
- has_many :likes

## Items テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| category1_id  | integer    | null: false                    |
| category2_id  | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :itemtags
- has_many :likes
- has_one_attached :image

## Item_tags テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item   | references | null: false, foreign_key: true |
| tag    | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :tag

## Tags テーブル

| Column   | Type   | Options                       |
| -------- | ------ | ----------------------------- |
| tag_name | string | null: false, uniqueness: true |

### Association

- has_many :itemtags

## Likes テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## Relationship テーブル

| Column    | Type       | Options                                 |
| --------- | ---------- | --------------------------------------- |
| following | references | null: false, foreign_key: :following_id |
| follower  | references | null: false, foreign_key: :follower_id  |

### Association

- belongs_to :following, class_name: "User"
- belongs_to :follower, class_name: "User"

## Comments テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
