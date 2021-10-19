module ApplicationHelper
  # Can be called anywhere within the application to run this code
  # This will render the partial in views/application/_error_messages file
  # be aware of the missing _ 
  def error_messages_for(object)
    render(partial: 'application/error_messages', locals: {object: object})    
  end

  # Outputs a <span> containing true or false text
  def status_tag(boolean, options = {})
    options[:true_text] ||= ''
    options[:false_text] ||= ''

    if boolean 
      content_tag(:span, options[:true_text], class:'status true')
    else 
      content_tag(:span, options[:false_text], class:'status false')
    end 
  end 
end
