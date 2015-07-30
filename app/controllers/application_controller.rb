class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_assassin
  	@current_assassin ||= Assassin.find(session[:assassin_id]) if session[:assassin_id]
  end
  helper_method :current_assassin

  def authorize
  	redirect_to '/login' unless current_assassin
  end
  
end
