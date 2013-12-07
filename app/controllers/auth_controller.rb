class AuthController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    UserSession.create(user, true)

    redirect_to '/'
  end

  def destroy
    current_user_session.destroy
    redirect_to '/'
  end

  private

  def auth_hash
    request.headers['omniauth.auth']
  end
end
