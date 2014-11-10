Keepsakes::Application.routes.draw do
  root :to => 'days#show', defaults: { id: Date.yesterday.to_s }

  resources :passwords,
    :controller => 'clearance/passwords',
    :only       => [:new, :create]

  resource  :session,
    :controller => 'clearance/sessions',
    :only       => [:create, :destroy]

  resources :users, :controller => 'users' do
    resource :password,
      :controller => 'clearance/passwords',
      :only       => [:create, :edit, :update]
  end

  resources :days,
    :only => [:show]

  get 'days/', to: 'days#show', defaults: { id: Date.yesterday.to_s }

  resources :texts,
    :only => [:create, :new, :destroy]

  resources :texts do
    collection do
      get 'destroy_all'
    end   
  end

  match 'account'  => 'users#edit'

  match '/auth/moves/callback' => 'moves#callback'
  match '/moves/logout' => 'moves#destroy'

  match '/auth/instagram/callback' => 'instagram#callback'
  match '/instagram/logout' => 'instagram#destroy'
end
