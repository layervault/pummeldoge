Pummeldoge::Application.routes.draw do
  scope controller: 'auth', path: 'auth' do
    get '/:provider/callback', action: 'create'
    get 'destroy'
  end
end
