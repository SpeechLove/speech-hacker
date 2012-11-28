SpeechHacker::Application.routes.draw do
  resources :speeches

  root :to => "meetings#index"
  resources :meetings
  resources :attendances, :only => [:create, :update]
  resources :users
  devise_for :users
  post '/users/:id/make_admin' => 'users#make_admin', :as => 'make_admin_user'
end
