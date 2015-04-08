Rails.application.routes.draw do

  devise_for :users

    resources :users, :only => [:show, :create, :update, :destroy], defaults: { format: :json } do
      resources :projects, :only => [:create, :update, :destroy], defaults: { format: :json } do
        resources :photos, :only => [:create, :update, :destroy], defaults: { format: :json }
      end
    end

    resources :sessions, :only => [:create, :destroy], defaults: { format: :json }
    resources :projects, :only => [:show, :index, :create, :update, :destroy], defaults: { format: :json }, via: :options do
      resources :photos, :only => [:index, :create, :update, :destroy], defaults: { format: :json }
    end
    # resources :photos, :only => [:featured], defaults: { format: :json }

    get 'featured', to: 'photos#featured', defaults: { format: :json }
    get 'flickr/:project_id', to: 'photos#flickr', defaults: { format: :json }

end
