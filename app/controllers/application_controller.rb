class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  force_ssl

  helper_method :current_user_session, :current_user

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      flash[:notice] = "You are not an admin."
      redirect_to '/auth/layervault'
    end
  end

  def require_admin
    unless current_user && current_user.is_admin
      flash[:notice] = "You are not an admin."
      redirect_to current_user ? '/auth/layervault' : 'https://layervault.com'
    end
  end
end
