class ApplicationController < ActionController::Base

  def index 
    @pages = Page.order("created_at DESC").all
  end 
end
