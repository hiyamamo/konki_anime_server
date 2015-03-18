// 追加ボタンクリック
$(document).on("click", "[id='add']", function(e){
    var num = $("#inputTbl > tbody > tr:last td:first").html();
    var next_num = parseInt(num) + 1;

    var newTr = $(this).parent().parent().clone().appendTo("#inputTbl > tbody");
    $(newTr).children(":first").html(next_num);
});

// 削除ボタンクリック
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

// 登録ボタンクリック
$(function(){
  $("#submit").click(function(){
    var params = {};
    var i = 0;
    $("#inputBody > tr").each(function(){
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

// 編集ボタンクリック
$(document).on("click", "[id='edit']", function(e){
  $(this).parent().siblings(":lt(4)").each(function(){
    $(this).replaceWith("<td><input type='text' name='" + $(this).attr("name") 
      + "' value='" + $(this).html() + "'></input></td>");
  });
  var day_of_week = $(this).parent().siblings("td[name='day_of_week']");
  $(day_of_week).replaceWith("<td><input type='text' name='day_of_week' list='week' autocomplete='on' value='" + day_of_week.html() + "'></input></td>");
  var tv_station = $(this).parent().siblings("td[name='tv_station']");
  $(tv_station).replaceWith("<td><input type='text' name='tv_station' list='tv' autocomplete='on' value='" + tv_station.html() + "'></input></td>");
  $(this).parent().parent().append("<td><button type='button' id='cancell'>キャンセル</button></td>");
  $(this).replaceWith("<button type='button' name='commit' id='commit'>更新</button>");
});

// キャンセルボタンクリック
$(document).on("click", "[id='cancell']", function(){
  $(this).parent().siblings(":lt(6)").each(function(){
    var name = $(this).children("input").attr("name");
    var value = $(this).children("input").val();
    $(this).replaceWith("<td name='" + name +
      "'>" + value + "</td>");
  });
  $(this).parent().siblings(":eq(6)").replaceWith("<td><button type='button' name='edit' id='edit'>編集</button></td>")
  $(this).parent().remove();
});

// 更新ボタンクリック
$(document).on("click", "[id='commit']", function(){
  var id = $(this).parent().siblings("input[name='id']").val();
  var params = {};
  params['id'] = id;
  $(this).parent().siblings("td").each(function(){
    var name = $(this).children("input").attr("name");
    params[name] = $(this).children("input").val();
  });
  $.post("/update", params, function(data){
    location.reload();
  });
});

// 全件削除ボタン確認
function checkSubmit(){
  return confirm("全件削除？");
}
