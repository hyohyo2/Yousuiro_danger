json.data do
  json.items do
    json.array!(@posts) do |post|
      json.id post.id
      json.user do
        json.name post.user.name
        json.image url_for(post.user.profile_image)
      end
      json.image url_for(post.image)
      json.post_code post.post_code
      json.prefecture_address post.prefecture_address
      json.city_address post.city_address
      json.block_address post.block_address
      json.detail post.detail
      json.status post.status
      json.latitude post.latitude
      json.longitude post.longitude
    end
  end
end
