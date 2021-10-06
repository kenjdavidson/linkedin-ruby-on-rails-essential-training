class DemoController < ApplicationController

  # Turn off layout behavior for some reason
  layout false

  # root /
  def index
  end

  # demo/hello
  def hello
    @name = params[:name]
    @array = *1..10
  end

  def nopes
    redirect_to(action: hello)
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
