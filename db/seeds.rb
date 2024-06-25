# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) do |admin|
  admin.password = ENV["ADMIN_PASSWORD"]
end

# ユーザ情報
taro = User.find_or_create_by!(email: 'test@test') do |user|
  user.password = 'example'
  user.name = 'テスト太郎'
  user.introduction = 'よろしくね'
  user.is_active = true
end

hanako = User.find_or_create_by!(email: 'test1@test') do |user|
  user.password = 'example'
  user.name = 'テスト花子'
  user.introduction = 'よろしくおねがいします'
  user.is_active = true
end

jiro = User.find_or_create_by!(email: 'test2@test') do |user|
  user.password = 'example'
  user.name = 'テスト二郎'
  user.introduction = 'よろしくお願いいたします。'
  user.is_active = true
end

# 投稿情報
# 投稿画像を変更すること
post = taro.posts.create!(
  image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/danger1.jpg")),filename: 'danger1.jpg'),
  post_code: '7000913',
  prefecture_address: '岡山県',
  city_address: '岡山市北区',
  block_address: '大供×××-×××',
  detail: 'ここは柵がないので、近くを通るときはお気を付けください。',
  status: 0
)

hanako.posts.create!(
  image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/safe.jpg")),filename: 'safe.jpg'),
  post_code: '7010221',
  prefecture_address: '岡山県',
  city_address: '岡山市南区',
  block_address: '藤田×××-×××',
  detail: '最近柵が設置されました！',
  status: 1
)

jiro.posts.create!(
  image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/danger2.jpg")),filename: 'danger2.jpg'),
  post_code: '7100833',
  prefecture_address: '岡山県',
  city_address: '倉敷市',
  block_address: '西中新田×××-×××',
  detail: 'ここの用水路は転落防止の柵がないのでお気を付けください。',
  status: 0
)

jiro.post_comments.create!(
  post: post,
  comment: "とてもいい投稿ですね"
)

hanako.post_comments.create!(
  post: post,
  comment: "気を付けます！！"
)