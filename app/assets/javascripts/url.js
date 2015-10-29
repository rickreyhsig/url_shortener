$(function() {

    if ($('#ajax_index').length > 0) {
        setTimeout(updateIndex,5000); 
    }
/*
  if ($("#comments").length > 0) {
    setTimeout(updateComments, 10000);
  } */
});

function updateIndex(){
    var url_id = $('#urls_table tr').eq(-1).attr('data-id');
    var after = $('#urls_table tr').eq(-1).attr('data-time');
    $.getScript("/urls.js?id=" + url_id + "&after=" + after);
    //$.getScript("/urls.js");
    setTimeout(updateIndex,5000); 
}

/*
function updateComments () {
  var article_id = $("#article").attr("data-id");
  if ($(".comment").length > 0) {
    var after = $(".comment:last-child").attr("data-time");
  } else {
    var after = "0";
  }
  $.getScript("/comments.js?article_id=" + article_id + "&after=" + after)
  setTimeout(updateComments, 10000);
}
*/