class AuthController < ApplicationController
  def create
    logger.info auth_hash.uid
    logger.info auth_hash.info
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
    # logger.info
    # request.env['omniauth.auth'] # TODO this is not Rails4 compatible
    request.headers['omniauth.auth']
  end
end
