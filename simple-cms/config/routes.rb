Rails.application.routes.draw do
  # Demo
  root 'demo#index'

  get 'demo/hello'
  get 'demo/nopes'

  # User Routes
  get 'users/new'
  get 'users/edit'
  get 'users/login'
  get 'users/logout'

  # Default route
  get ':controller(/:action(/:id))'
end
