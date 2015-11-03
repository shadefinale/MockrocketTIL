module SessionsHelper
  def sign_in_or_out_link(current_user)
    if current_user
      link_to('Sign Out', sessions_path, method: "DELETE", class: 'btn btn-default')
    else
      link_to('Sign In/Up', new_author_path, class: 'btn btn-default')
    end
  end

  def link_to_current_user(current_user)
    if current_user
      link_to("#{current_user.username.capitalize}'s Posts", current_user, class: 'btn btn-default')
    end
  end
end
