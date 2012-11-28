$(document).ready(function() {
  $('.make-admin-option').on('click', function(e) {
    console.log("heloooo");
    e.preventDefault();
    var $self = $(this),
        params = $self.serialize();

    $.ajax({
      type: 'post',//$self.attr('post'),
      url:  '/users/' + $self.val() + '/make_admin',//$self.attr('/' + $self.val() + '/make_admin'),
      dataType: 'json',
      data: params,
        success: function(data, status, xhr) {
          console.log("ajax success");
          if ($self.attr('checked')) {
            $self.prop('checked', false);
          } else {
            $self.prop('checked', true);
          }
          //$self.trigger('ajax:success', [data, status, xhr]);
        },
        error: function(xhr, status, error) {
          console.log("ajax error");
          //$self.trigger('ajax:error', [xhr, status, error]);
        },
        complete: function(xhr, status) {
          console.log("ajax complete");
          //$self.trigger('ajax:complete', [xhr, status]);
        }
    }); // ajax

  }); // on make_admin_option

});