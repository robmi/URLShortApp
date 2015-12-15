class ApplicationController < ActionController::Base

  helper_method :current_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do |exception|
   logger.warn(exception.class.name + ": " + exception.message)
   render "/not_found"
 end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize!
    if current_user.nil?
      flash[:error] = "You must signed in to access this page."
      redirect_to root_path
    end
  end

  def api_authenticate_user
    authenticate_with_http_token do |token|
      @current_user = User.find_by(api_key: token)
    end
  end

end
