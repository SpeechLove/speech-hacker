$(document).ready(function() {
/*
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
    var params = "manual_id="+$(this).val();

    $.ajax({
      type: 'get',
      url:  '/manuals/' + $(this).val() + '/projects/',
      dataType: 'json',
      data: params,
        success: function(data, status, xhr) {
          replace_projects(data["projects"]);
        },
        error: function(xhr, status, error) {

        }
    }); // ajax
  });

  function replace_projects(projects) {
    var $select_elem = $(".project-select");
    $select_elem.empty(); // remove old options
    for (var i = 0; i < projects.length; i++) {
      $select_elem.append($("<option></option>")
         .attr("value", projects[i].id).text(projects[i].name));
    }
  }

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
*/
});