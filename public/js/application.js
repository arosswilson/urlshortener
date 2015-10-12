$(document).ready(function() {
  $('#url-creator').on('click', function(event){
    $('.notice').empty();
    event.preventDefault();
    var $submissiondata = $(event.target.parentElement).serialize();
    $.ajax({
      type: 'POST',
      url: '/urls',
      data: $submissiondata
    })
    .success(function(response){
      if(response.endsWith("'http://'\"}")){
        response = JSON.parse(response)
        $('.notice').append(response.error)
      }
      else {
        $(".new-urls").prepend(response);
      }
    })
    .fail(function(response){
      console.log('error');
    })
  })
});
