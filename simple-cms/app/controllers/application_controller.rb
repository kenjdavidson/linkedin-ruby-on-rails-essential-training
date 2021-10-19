class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_user_preferences

protected
  def set_user_preferences
    @username = cookies[:username]
    @language = cookies[:language]
  end 

  def confirm_logged_in
    if session[:user_id].present?
      return true;
    else 
      flash[:warning] = 'Please log in'
      redirect_to(login_path)
    end 
  end 

  def render_404
    filepath = Rails.root.join('public', '404.html')
    render(file: filepath, status: 404) and return
  end 
end
