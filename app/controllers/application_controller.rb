class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

#   def current_user
#   @current_user ||= User.find_by(id: session[:user_id])
#
#   if @current_user.nil? && session[:user_id]
#     session[:user_id] = nil
#     redirect_to login_path
#   else
#     @current_user
#   end
# end
end
