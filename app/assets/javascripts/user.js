$(document).ready(function() {
  hide_success_box();
  hide_errors_box();

  $('.make-admin-option').on('click', function(e) {
    e.preventDefault();
    var $self = $(this),
        params = $self.serialize();

    $.ajax({
      type: 'post',
      url:  '/users/' + $self.val() + '/make_admin',
      dataType: 'json',
      data: params,
        success: function(data, status, xhr) {
          var close_box = '<a class="close" data-dismiss="alert">&#215;</a>';

          if ($self.attr('checked')) {
            $self.prop('checked', false);

            var icon_minus = '<i class="icon-minus"></i>';
            $('.success-box').html(close_box + icon_minus + '\nAdmin privilege <strong>removed</strong>!');
          } else {
            $self.prop('checked', true);

            var icon_plus = '<i class="icon-plus"></i>';
            $('.success-box').html(close_box + icon_plus + '\nAdmin privilege <strong>added</strong>!');
          }
          $('.errors-box').hide();
          $('.success-box').fadeIn('fast');
        },
        error: function(xhr, status, error) {
          var close_box = '<a class="close" data-dismiss="alert">&#215;</a>';
          $('.success-box').hide();
          $('.errors-box').html(close_box + '\nAn error has occured.');
          $('.errors-box').fadeIn('fast');
        }
    }); // ajax
  }); // on make_admin_option

  function hide_success_box() {
    $('.success-box').hide();
  }

  function hide_errors_box() {
    $('.errors-box').hide();
  }
});