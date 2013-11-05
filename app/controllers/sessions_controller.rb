class SessionsController < ApplicationController
  before_filter :require_current_user!, :only => [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user])

    if !!@user
      login_user!(@user)
      redirect_to @user
    else
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    end
  end

  def destroy
    logout_user!(current_user)
    redirect_to new_session_url
  end
end
