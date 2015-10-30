class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def redirect_back
      redirect_to (request.referer.present? ? :back : root_path)
    end

    def current_user
      @current_user ||= Author.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
    end
    helper_method :current_user

    def sign_in(user)
      user.auth_token ? user.regenerate_auth_token : user.generate_auth_token
      cookies[:auth_token] = user.auth_token
      @current_user = user
    end

    def sign_out
      @current_user = nil
      cookies.delete(:auth_token)
    end

    def require_logged_in
      unless current_user
        flash[:notice] = "You must be logged in!"
        redirect_to referer
      end
    end

    def require_owner
      unless current_user == @author
        flash[:notice] = "You must own this content to do this action!"
        redirect_to root_path
      end
    end

    def store_referer
      if request && request.referer
        session[:referer] = URI(request.referer).path
      else
        session[:referer] = root_path
      end
    end

    def referer
      session.delete(:referer)
    end
end
