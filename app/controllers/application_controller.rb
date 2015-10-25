class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def redirect_back
      redirect_to (request.referer.present? ? :back : root_path)
    end
end
