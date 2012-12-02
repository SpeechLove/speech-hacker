$(document).ready(function(){
  setEvents();
//        $('#calendar').Calendar({ 'events': evnts, 'weekStart': 7 })
   // .on('changeDay', function(event){ alert(event.day.valueOf() +'-'+ event.month.valueOf() +'-'+ event.year.valueOf() ); })
   // .on('onEvent', function(event){ alert(event.day.valueOf() +'-'+ event.month.valueOf() +'-'+ event.year.valueOf() ); })
   // .on('onNext', function(event){ alert("Next"); })
   // .on('onPrev', function(event){ alert("Prev"); })
   // .on('onCurrent', function(event){ alert("Current"); });
  function setEvents() {
    $.ajax({
      url: '/meetings',
      type: 'get',
      dataType: 'json',
      success: function(data) {
        $('#calendar').Calendar({ 'events': function() {
          return data.meetings
        }, 'weekStart': 7 })
      }
    });
  }

});