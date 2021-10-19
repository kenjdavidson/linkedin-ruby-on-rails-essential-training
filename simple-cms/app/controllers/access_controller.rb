class AccessController < ApplicationController
  before_action :confirm_logged_in, except: [:new, :create]

  def menu
    @user_id = session[:user_id]
  end

  def new
  end

  def create
    logger.info("#{self.class} >> Processing login attempt with user: #{params[:username]}")    
    session[:user_id] = 1234
    cookies[:username] = params[:username]
    cookies[:language] = 'en'

    logger.info("#{self.class} >> Successfully logged in user: #{params[:username]}")

    redirect_to(menu_path)
  end

  def destroy
    logger.info("#{self.class} >> Logging user #{session[:user_id]} out")

    session[:user_id] = nil
    cookies.delete :username

    redirect_to(login_path)
  end
end
