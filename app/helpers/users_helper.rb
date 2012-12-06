module UsersHelper
  def show_user_link(user)
    link_to user.name, user_path(user)
  end

  def edit_user_link(user)
    link_to "<i class=\"icon-pencil\"></i> Edit member".html_safe, edit_user_path(user.id)
  end

  def make_user_admin(user)
    if current_user.super_admin?
      if !user.super_admin?
        is_admin = (user.admin? or user.super_admin?)
          check_box_tag 'make_admin', user.id, is_admin, :class => "make-admin-option"
      else
        ""
      end
    end
  end
end
