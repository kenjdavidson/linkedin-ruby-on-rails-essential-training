Rails.application.routes.draw do
  # Demo
  root 'demo#index'

  get 'demo/hello'
  get 'demo/nopes'

  # Resources
  resources :subjects do 
    member do 
      get :delete
    end
  end

  resources :pages do 
    member do 
      get :delete
    end
  end

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
