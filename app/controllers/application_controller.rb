class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
  private
  	def current_user
  		@current_user ||= Member.find(session[:user_id]) if session[:user_id]
  	end
  	def authenticated
  		redirect_to root_url unless current_user.nil?
  	end
    def authenticate_user
      redirect_to profile_login_path, notice: 'User needs to be authenticated' unless session[:user_id]
    end
    def check_session
      redirect_to profile_index_path, :notice => 'user already logged in' unless session[:user_id].nil?
    end
  	helper_method :current_user
    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
    after_filter :store_location

def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
  return unless request.get? 
  if (request.path != "/users/login" &&
      request.path != "/users/sign_up" &&
      request.path != "/users/password/new" &&
      request.path != "/users/password/edit" &&
      request.path != "/users/confirmation" &&
      request.path != "/users/sign_out" &&
      !request.xhr?) # don't store ajax calls
    session[:previous_url] = request.fullpath 
  end
end

def after_sign_in_path_for(resource)
  session[:previous_url] || root_path
end
end
