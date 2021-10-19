class DemoController < ApplicationController

  # root /
  def index
    @pages = Page.includes(:subject).first(6)
  end

  def about
    render('about_us')
  end

  def contact
    @country = params[:country]

    case @country
    when 'ca','us'
      @phone = '1 (800) 123-1245'
    when 'uk'
      @phone = '020 0124151 125100'
    else 
      @phone = '+1 (987) 123-2356'
    end

    render('contact_us')
  end 
end
