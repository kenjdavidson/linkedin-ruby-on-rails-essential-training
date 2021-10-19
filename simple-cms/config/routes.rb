Rails.application.routes.draw do
  # Demo
  root 'demo#index'

  get 'about' => 'demo#about'
  get 'contact-us' => 'demo#contact_us'

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

  # Access Routes
  # Important part here is the `resource` fakeout to get the access_path created (I think)
  get 'menu' =>'access#menu'
  get 'login' => 'access#new'
  post 'access/new' => 'access#create'
  delete 'logout' => 'access#destroy'
 
  # Subject and Page Routes
  resources :subjects do 
    resources :pages
  end
  

  # Default route
  get ':controller(/:action(/:id))'
end
