Rails.application.routes.draw do

  devise_for :users
  require 'api_constraints'


  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
        resources :users, :only => [:show, :create, :update, :destroy] do
          resources :projects, :only => [:create, :update, :destroy]
        end

        resources :sessions, :only => [:create, :destroy]
        resources :projects, :only => [:show, :index, :create, :update, :destroy] do
          resources :photos, :only => [:index]
        end

    end


  end


end
