$(function(){
  var arr = { 'admin_phone_number': "websiteuser" };
  var keys = [];
  $.ajax({
  url: '/api/ema_admin_user_data',
  type: 'POST',
  data: JSON.stringify(arr),
  contentType: 'application/json; charset=utf-8',
  dataType: 'json',
  async: true,
  success: function(msg) {
        for(var k in msg) {
          keys.push(k);
          $("#userDataList").append("<li><a id='induser' onclick=showMore("+k+')>'+" "+k+" "+msg[k].first_name+" "+msg[k].last_name+" "+'</a></li>');
          $("#userDataListHeader").html("User Data")
        }
        $('#induser').click(function() {
          //var phno = $(this).data("phno")
          alert("phno");
        });
    }
  });
  $.ajax({
  url: '/api/ema_admin_temp_data',
  type: 'POST',
  data: JSON.stringify(arr),
  contentType: 'application/json; charset=utf-8',
  dataType: 'json',
  async: true,
  success: function(msg) {
        for(var k in msg) {
          keys.push(k);
          $("#userTempList").append("<li><a id='induser' onclick=showMore("+k+')>'+" "+k+" "+msg[k].temperature+" "+msg[k]['Date-time']+" "+'</a></li>');
          $("#userTempListHeader").html("Temperature Data")
        }
        $('#induser').click(function() {
          //var phno = $(this).data("phno")
          alert("phno");
        });
    }
  });



});
function showMore(e){
  alert(e)
}
