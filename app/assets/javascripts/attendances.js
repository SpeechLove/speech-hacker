$(document).ready(function() {
  show_hide_role_sign_up();
  hide_role_id();
  hide_alert_boxes();

  var old_user_id;

  // Delete member roles from meeting through the delete link.
  $('.remove-meeting-role').on('click', function(e) {
    e.preventDefault();
    old_user_id = $(this).prev().find(":selected").val()
    user_id = "";
    role_id = $(this).parent().parent().find('.role-title-id').html();
    meeting_id = $('#meeting_id').val();
    selected_element_id = $(this).prev().attr('id');

    var params = "old_user_id=" + old_user_id + "&user_id=" + user_id + "&role_id=" + role_id;

    $.ajax({
      type: 'post',
      url:  '/meetings/' + meeting_id + '/attendances',
      dataType: 'json',
      data: params,
        success: function(data, status, xhr) {
          show_success_box('Your update has been made successfully!');
          // Change the dropdown box to "Select a member"
          $('#' + selected_element_id).val('');
          refresh_attendee_list(data["all_attendees"]);
        },
        error: function(xhr, status, error) {
          show_error_box('Something is wrong! Your update did not go through!');
        }
    }); // ajax
  });

  // Update member roles in current meeting through changes to the
  // drop-down box.
  $('.attendance-role-select').focus(function() {
    old_user_id = $(this).val();
  }).change(function() {
    user_id = $(this).val();
    role_id = $(this).parent().parent().find('.role-title-id').html();
    meeting_id = $('#meeting_id').val();

    var params = "old_user_id=" + old_user_id + "&user_id=" + user_id + "&role_id=" + role_id;

    $.ajax({
      type: 'post',
      url:  '/meetings/' + meeting_id + '/attendances',
      dataType: 'json',
      data: params,
        success: function(data, status, xhr) {
          show_success_box('Your update has been made successfully!');
          refresh_attendee_list(data["all_attendees"]);
        },
        error: function(xhr, status, error) {
          show_error_box('Something is wrong! Your update did not go through!');
        }
    }); // ajax
  });

  // Show role options if the user selects to attend the meeting
  $('.attend-option').on('click', function(e) {
    if ($(this).val() == 'true') {
      $('.role-sign-up').fadeIn('fast');
    } else {
      $('.role-sign-up').fadeOut('fast');
    }
  });

  // Show speech options when the speaker role is selected
  $('.role-option').on('click', function(e) {
    if ($(this).val() == $('.Speaker-option').val())
      $('.speech-fields').fadeIn('fast');
    else
      $('.speech-fields').fadeOut('fast');
  });

  // Change project options when the selected manual is changed
  $('.manual-select').change(function(){
    var params = "manual_id="+$(this).val();

    $.ajax({
      type: 'post',
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

  function refresh_attendee_list(all_attendees) {
    $('#attendee_list').html('');
    for (var i = 0; i < all_attendees.length; i++) {
      $("#attendee_list").append('<li>' + all_attendees[i].name + '</li>');
    }
  }

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

  function hide_alert_boxes() {
    $('.notice-box').hide();
    $('.alert-box').hide();
  }

  function hide_role_id() {
    $('.role-title-id').hide();
  }

  function show_success_box(display_html) {
    $('.notice-box').html(display_html);
    $('.alert-box').hide();
    $('.notice-box').fadeIn('fast');
  }

 function show_error_box(display_html) {
   $('.alert-box').html(display_html);
   $('.notice-box').hide();
   $('.alert-box').fadeIn('fast');
  }
});