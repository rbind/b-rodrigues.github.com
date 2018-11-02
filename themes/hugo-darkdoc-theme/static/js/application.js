$.getJSON( api_url, function( data ) {
  $('#star_count').replaceWith(data["stargazers_count"])
});
$(function(){
  $('.navbar-toggle').on('click', function(){
    $('.table-of-contents').slideToggle();
  });
});
