module SessionsHelper
  def login_user!(user)
    session[:token] = user.reset_session_token!
  end

  def logout_user!(user)
    user.reset_session_token!
    session[:token] = nil
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def logged_in?
    !!current_user
  end

  def require_current_user!
    unless logged_in?
      flash[:errors] = ["You must be logged in for this resource!"]

      respond_to do |format|
        format.html { redirect_to new_session_url }
        format.json { render :json => flash[:errors], :status => 404 }
      end
    end
  end

  def require_logged_out!
    redirect_to current_user if logged_in?
  end
end
