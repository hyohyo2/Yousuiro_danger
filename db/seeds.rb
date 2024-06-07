# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ユーザ情報
User.create!(
  email: 'test@test.com',
  password: 'example',
  name: 'テスト太郎',
  introduction: 'よろしくね',
  is_active: true
)
User.create!(
  email: 'test1@test.com',
  password: 'example',
  name: 'テスト花子',
  introduction: 'よろしくおねがいします',
  is_active: true
)

# 投稿情報
Post.create!(
  user_id: User.find_by(name: 'テスト太郎').id,
  image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/default-image.jpg")),filename: 'default-image.jpg'),
  post_code: '1234567',
  prefecture_address: '岡山県',
  city_address: '岡山市北区',
  block_address: '岡山町１２３４',
  detail: 'ここは柵がなくて危険です！近くを通るときはお気を付けください。',
  status: 0
)

Post.create!(
  user_id: User.find_by(name: 'テスト花子').id,
  image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/default-image.jpg")),filename: 'default-image.jpg'),
  post_code: '1234567',
  prefecture_address: '岡山県',
  city_address: '岡山市北区',
  block_address: '岡山町２３４５',
  detail: 'ここは柵がなく危険でしたが、昨日柵が設置されました！',
  status: 1
)