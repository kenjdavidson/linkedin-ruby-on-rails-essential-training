module SubjectsHelper
  # Can be called anywhere within the application to run this code
  # This will render the partial in views/application/_error_messages file
  # be aware of the missing _ 
  def error_messages_for(object)
    render(partial: 'application/error_messages', locals: {object: object})    
  end
end
