Keepsakes::Application.routes.draw do
  root :to => 'days#show'

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
