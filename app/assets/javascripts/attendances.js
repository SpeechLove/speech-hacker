$(document).ready(function() {
  show_hide_role_sign_up();

  $('.attend-option').on('click', function(e) {
    if ($(this).val() == 'true') {
      $('.role-sign-up').fadeIn('fast');
    } else {
      $('.role-sign-up').fadeOut('fast');
    }
  });

  $('.role-option').on('click', function(e) {
    if ($(this).val() == $('.Speaker-option').val())
      $('.speech-fields').fadeIn('fast');
    else
      $('.speech-fields').fadeOut('fast');
  });

  $('.manual-select').change(function(){
    console.log("this val:" + $(this).val());

    var params = "manual_id="+$(this).val();

    console.log("params: " + params);

    $.ajax({
      type: 'get',
      url:  '/manuals/' + $(this).val() + '/projects/',
      dataType: 'json',
      data: params,
        success: function(data, status, xhr) {
          console.log("ajax success");
          for (var i = 0; i < data["projects"].length; i++) {
            console.log(data["projects"][i].name);
          }
        },
        error: function(xhr, status, error) {

        }
    }); // ajax
  });

  function show_hide_role_sign_up() {
    if ($('#attendance_attend_true').attr('checked')) {
      $('.role-sign-up').show();
    } else if ($('#attendance_attend_false').attr('checked')){
      $('.role-sign-up').hide();
    }

    if ($('.Speaker-option').attr('checked')) {
      $('.speech-fields').show();
    } else {
      $('.speech-fields').hide();
    }
  }
});