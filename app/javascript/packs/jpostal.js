function jpostal(){
  $('#post_code').jpostal({
    postcode : ['#post_post_code'],
    address : {
      '#post_prefecture_address': '%3',
      '#post_city_address': '%4',
      '#post_block_address': '%5'
    }
  });
}
$(document).on("turbolinks:load", jpostal);