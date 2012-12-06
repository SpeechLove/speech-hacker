$(document).ready(function() {
  hide_success_box();

  $('.make-admin-option').on('click', function(e) {
    e.preventDefault();
    var $self = $(this),
        // params = $self.serialize(),
        admin = $self.attr('checked'),
        params = { admin: admin };
    if (admin) {
      params = { admin: true };
    } else {
      params = { admin: false };
    }

    $.ajax({
      type: 'put',
      url:  '/users/' + $self.val(),
      dataType: 'json',
      data: params,
        success: function(data, status, xhr) {
          if ($self.attr('checked')) {
            $self.prop('checked', false);
            $('.success-box').text('Admin privilege removed!');
          } else {
            $self.prop('checked', true);
            $('.success-box').text('Admin privilege added!');
          }
          $('.success-box').show();
        },
        error: function(xhr, status, error) {

        }
    }); // ajax
  }); // on make_admin_option

  function hide_success_box() {
    $('.success-box').hide();
  }

});