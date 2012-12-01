SpeechHacker::Application.routes.draw do
  root :to => "meetings#index"
  resources :meetings
  resources :attendances, :only => [:create, :update]
  devise_for :users
  resources :meeting_roles
  get "/users/:id/progress" => "users#progress", :as => "user_progress"
  resources :users do
  	resources :manuals, :only => [:index, :show]
  end
  resources :speeches, :only => [:index]

  get "/manuals/:id/projects" => "projects#projects_by_manual"
  post '/users/:id/make_admin' => 'users#make_admin', :as => 'make_admin_user'
end
