SpeechHacker::Application.routes.draw do
  resources :speeches

  root :to => "meetings#index"
  resources :meetings
  resources :attendances, :only => [:create, :update]
  devise_for :users
  resources :users

  post '/users/:id/make_admin' => 'users#make_admin', :as => 'make_admin_user'
end
