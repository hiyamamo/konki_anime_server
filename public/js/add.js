$(document).on("click", "[id='add']", function(e){
    var num = $("#inputTbl > tbody > tr:last td:first").html();
    var next_num = parseInt(num) + 1;

    var newTr = $(this).parent().parent().clone().appendTo("#inputTbl > tbody");
    $(newTr).children(":first").html(next_num);
});

$(document).on("click", "[id='delete']", function(e){
  var max_num = $(this).parent().parent().siblings().length;
  if(max_num == 0){
    return;
  }
  var num = $(this).parent().siblings(":first").html();
  var trElement = $(this).parent().parent();
  var nextSib = $(trElement).nextAll();
  $(nextSib).each(function(){
    var old_num = $(this).children(":first").html();
    var new_num = parseInt(old_num) - 1;
    $(this).children(":first").html(new_num);
  });
  $(trElement).remove();
});

$(function(){
  $("#submit").click(function(){
    var params = {};
    var i = 0;
    $("#inputBody > tr").each(function(){
      var t = $(this).find("input");
      params[i] = {};
      $(this).find("input").each(function(){
        var key = $(this).attr("name").toString();
        params[i][key] = $(this).val();
      });
      i++;
    });
    $.post("/new", params, function(data){
      location.reload();
    });
  });
});
