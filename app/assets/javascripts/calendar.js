$(document).ready(function(){

      //$('#calendar').Calendar({ 'events': evnts, 'weekStart': 7 })
   // .on('changeDay', function(event){ alert(event.day.valueOf() +'-'+ event.month.valueOf() +'-'+ event.year.valueOf() ); })
   //.on('onEvent', function(event){ alert(event.day.valueOf() +'-'+ event.month.valueOf() +'-'+ event.year.valueOf() ); })
   // .on('onNext', function(event){ alert("Next"); })
   // .on('onPrev', function(event){ alert("Prev"); })
   // .on('onCurrent', function(event){ alert("Current"); });

    $.ajax({
      url: '/meetings',
      type: 'get',
      dataType: 'json',
      success: function(data) {
        $('#calendar').Calendar({ 'events': function() {
          return data.meetings
        }, 'weekStart': 7 }).on('onEvent', function(event) {
          changeAccordion(event);
        })
          .on('onNext', function(event){
            console.log(event.month);
        })
          .on('onPrev', function(event){
            console.log(event.month);
        })
          .on('onCurrent', function(event){
            console.log(event.month);
        });
      }
    });

    var changeAccordion = function(event) {
      var day = checkZero(event.day);
      var date = event.month + "/" + day + "/" + event.year;
      accordion = $('.accordion-toggle:contains(' + date + ')');
      accordionChild = $('.accordion-body.in');
      if(accordionChild.hasClass('in')) {
        accordionChild.siblings().children().click();
      }
      accordion.click();
    };

  function checkZero(day) {
      if (day < 10) {
        return "0" + day;
      } else {
        return day;
      }
  };


});


