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

(function workers_status(interval){
  $.ajax(
    {
      url: "/execution/workers_status",
      success: function(data) {
        $('#workers-status').empty();
        $('#workers-status').append(data);
        setTimeout(function() { workers_status(interval); }, interval);
      },
      error: function(data) {
        setTimeout(function() { workers_status(interval * 2); }, interval);
      },
      dataType: "html",
      timeout: interval
    });
})(10000);
