# frozen_string_literal: true

# handles application-level functionality
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  before_action :require_login

  def current_user
    @current_user ||= Account.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    if ! logged_in?
      flash[:warning] = 'You must be logged in to perform that action'
      redirect_to login_path
    end
  end
end
