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
        $('.accordion-toggle').addClass('collapsed');
      }
    });


    var changeAccordion = function(event) {

      var day = checkZero(event.day);
      var date = event.month + "/" + day + "/" + event.year;
      accordion = $('.accordion-toggle:contains(' + date + ')');
      accordionChild = $('.accordion-body.in');
      //reset all accordions to collapsed.
      //check the target accordion
        //if it's collapsed, open it
      if(accordionChild.hasClass('in')) {
        accordionChild.siblings().children().click();
      }
      accordion.click();
      //$('.accordion-body').removeClass('in');
      // if(accordionChild.hasClass('in')) {
      //   accordion.addClass('collapsed');
      //   accordionChild.removeClass('in');
      // } else {
      //   //$('.accordion-toggle').addClass('collapsed');
      //   accordion.removeClass('collapsed');
      //   accordionChild.addClass('in');
      // }

      // alert("current = " + event.currentTarget);
      // alert("target = " + event.target)
    };
  // $('.holiday').on('click', function() {
  //   console.log(this.day);
  // });


  function checkZero(day) {
      if (day < 10) {
        return "0" + day;
      } else {
        return day;
      }
  };


});


