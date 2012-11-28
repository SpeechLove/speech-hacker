SpeechHacker::Application.routes.draw do
  resources :speeches

  root :to => "meetings#index"
  resources :meetings
  resources :attendances, :only => [:create, :update]
  devise_for :users

  get '/users' => 'users#index', :as => 'users'
  get '/users/:id' => 'users#show', :as => 'user'
  put '/users/:id' => 'users#update', :as => 'user'
  get '/users/:id/edit' => 'users#edit', :as => 'edit_user'
  post '/users/:id/make_admin' => 'users#make_admin', :as => 'make_admin_user'
end
