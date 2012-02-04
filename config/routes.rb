PayMe::Application.routes.draw do

  root :to => 'payments#new'  
  match '/thanks' => 'payments#thanks', :as => :thanks
  get '/admin' => 'payments#index'
  
  resources :payments
  
  get '*asdf' => 'static#_404'
end
