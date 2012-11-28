SpeechHacker::Application.routes.draw do
  root :to => "meetings#index"
  resources :meetings
  resources :attendances, :only => [:create]
  devise_for :users
  get '/users' => 'users#index', :as => 'users'

end
