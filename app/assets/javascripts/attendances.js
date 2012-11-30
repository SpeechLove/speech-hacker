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
    console.log("this val:" + $(this).val());
    console.log("speaker-option val:" + $('.Speaker-option').val());
    if ($(this).val() == $('.Speaker-option').val())
      $('.speech-fields').fadeIn('fast');
    else
      $('.speech-fields').fadeOut('fast');
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