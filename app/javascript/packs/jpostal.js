function jpostal(){
  $('#post_code').jpostal({
    postcode : ['#post_code'],
    address : {
      '#prefecture_address': '%3',
      '#city_address': '%4',
      '#block_address': '%5'
    }
  });
}
$(document).on("turbolinks:load", jpostal);