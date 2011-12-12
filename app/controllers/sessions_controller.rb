class SessionsController < ApplicationController
  skip_before_filter :require_authentication

  def create
    user = User.find_by_user_id(params[:user_id])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now.alert = t(:invalid_credentials)
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sign_in_path, notice: t(:successful_sign_out)
  end
end
