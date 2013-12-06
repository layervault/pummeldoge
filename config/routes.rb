Pummeldoge::Application.routes.draw do
  scope controller: 'auth', path: 'auth' do
    get '/:provider/callback', action: 'create'
    get 'destroy'
  end

  resources :movies, only: [:create, :show]

  root 'home#index'
end
