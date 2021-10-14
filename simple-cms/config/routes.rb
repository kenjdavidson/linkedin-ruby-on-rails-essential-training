Rails.application.routes.draw do
  # Demo
  root 'application#index'

  # Resources
  resources :subjects do 
    resources :pages
  end
  
  # Resources do not have the extra delete that was added in previous lessons.  In most cases
  # this would be done with Javascript for confirmation.  This would only be required if there
  # were say other changes that were going to happen due to the deletion.  For example:
  # - Applying children to another parent 
  # - Confirming that subdata (foreign key data) could be lost forever
  # - etc.
  # resources :subjects do 
  #   member do 
  #     get :delete
  #   end
  # end

  # User Routes
  get 'users/new'
  get 'users/edit'
  get 'users/login'
  get 'users/logout'

  # get 'pages/index'
  # get 'pages/show'
  # get 'pages/new'
  # get 'pages/edit'
  # get 'pages/delete'
  # get 'subjects/index'
  # get 'subjects/show'
  # get 'subjects/new'
  # get 'subjects/edit'
  # get 'subjects/delete'
  
  # Default route
  get ':controller(/:action(/:id))'
end
