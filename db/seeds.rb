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
  image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/default-image.jpg")),filename: 'default-image.jpg'),
  post_code: '7008544',
  prefecture_address: '岡山県',
  city_address: '岡山市北区',
  block_address: '大供１－１',
  detail: 'ここは柵がなくて危険です！近くを通るときはお気を付けください。',
  status: 0
)

hanako.posts.create!(
  image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/default-image.jpg")),filename: 'default-image.jpg'),
  post_code: '7000023',
  prefecture_address: '岡山県',
  city_address: '岡山市北区',
  block_address: '駅元町１－１',
  detail: 'ここは柵がなく危険でしたが、昨日柵が設置されました！',
  status: 1
)

jiro.posts.create!(
  image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/default-image.jpg")),filename: 'default-image.jpg'),
  post_code: '7038544',
  prefecture_address: '岡山県',
  city_address: '岡山市中区',
  block_address: '浜三丁目７番１５号',
  detail: 'ここの用水路は学生の通学路ですが柵がありません。水深が深く転落すると非常に危険です。',
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