$(document).ready(function() {
  hide_success_box();

  $('.make-admin-option').on('click', function(e) {
    console.log("heloooo");
    e.preventDefault();
    var $self = $(this),
        params = $self.serialize();

    $.ajax({
      type: 'post',
      url:  '/users/' + $self.val() + '/make_admin',
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
          console.log("ajax error");
        },
        complete: function(xhr, status) {
          console.log("ajax complete");
        }
    }); // ajax
  }); // on make_admin_option

  function hide_success_box() {
    $('.success-box').hide();
  }

});