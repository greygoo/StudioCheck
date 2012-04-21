(function ping_redis(interval){
  $.ajax(
    { 
      url: "/execution/redis_status",
      success: function(data) {
        $('#redis-status').empty();
        $('#redis-status').append(data);
        setTimeout(function() { ping_redis(interval); }, interval);
      },
      error: function(data) {
        setTimeout(function() { ping_redis(interval * 2); }, interval);
      },
      dataType: "html",
      timeout: interval 
    });
})(10000);
