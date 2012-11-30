SpeechHacker::Application.routes.draw do
  root :to => "meetings#index"
  resources :meetings
  resources :attendances, :only => [:create, :update]
  devise_for :users

  resources :users do
  	resources :manuals, :only => [:index, :show]
  	resources :speeches, :only => [:index]
  end
  
  post '/users/:id/make_admin' => 'users#make_admin', :as => 'make_admin_user'
end
