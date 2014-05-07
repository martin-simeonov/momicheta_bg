class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	
  private
	def admin?
    @admin = false
    if not current_user.nil?
      Admin.all.each do |a|
        if a.user_id == current_user.id
          @admin = true
        end
      end
    end
    @admin 
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user, :admin?
end
