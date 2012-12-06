module AttendancesHelper
  def user_attending_field(f, meeting)
    if user_attending? meeting
      f.radio_button "attend", "true", :class => "attend-option", :checked => true
    else
      f.radio_button "attend", "true", :class => "attend-option", :checked => false
    end
  end

  def user_not_attending_field(f, meeting)
    if user_attending? meeting
      f.radio_button "attend", "false", :class => "attend-option", :checked => false
    else
      f.radio_button "attend", "false", :class => "attend-option", :checked => true
    end
  end
end