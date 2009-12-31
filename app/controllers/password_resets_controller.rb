class PasswordResetsController < ApplicationController
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  before_filter :require_no_user

  def new
    render :layout => 'user_sessions'
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:success] = "Instructions to reset your password have been emailed to you. Please check your email."
      redirect_to login_path
    else
      flash[:error] = "No user was found with that email address!"
      redirect_to new_password_reset_path
    end
  end

  def edit
    render :layout => 'user_sessions'
  end

  def update
    if params[:user][:password].empty? and params[:user][:password_confirmation].empty?
      redirect_to edit_password_reset_path and return
    end
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:success] = "Password successfully updated!"
      redirect_to root_path
    else
      render :action => :edit, :layout => 'user_sessions'
    end
  end

  private
    def load_user_using_perishable_token
      @user = User.find_using_perishable_token(params[:id])
      unless @user
        flash[:error] = "We're sorry, but we could not locate your account." +
          "If you are having issues try copying and pasting the URL " +
          "from your email into your browser or restarting the " +
          "reset password process."
        redirect_to login_path
      end
    end
end
