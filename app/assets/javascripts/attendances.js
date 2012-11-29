$(document).ready(function() {
  show_hide_role_sign_up();

  $('.attend-option').on('click', function(e) {
    if ($(this).val() == 'true') {
      $('.role-sign-up').fadeIn('fast');
    } else {
      $('.role-sign-up').fadeOut('fast');
    }
  });

  function show_hide_role_sign_up() {
    if ($('#attendance_attend_true').attr('checked')) {
      $('.role-sign-up').show();
    } else if ($('#attendance_attend_false').attr('checked')){
      $('.role-sign-up').hide();
    }
  }
});