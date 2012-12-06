SpeechHacker::Application.routes.draw do
  root :to => "meetings#index"
  resources :meetings
  resources :attendances, :only => [:create, :update]
  devise_for :users
  resources :meeting_roles
  resources :users do
  	resources :manuals
  end
  resources :speeches, :only => [:index]
  resources :projects, :only => [:index]

  get "/manuals/:id/projects" => "projects#update"
  post '/users/:id/make_admin' => 'users#index', :as => 'make_admin_user'
end
