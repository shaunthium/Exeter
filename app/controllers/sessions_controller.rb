class SessionsController < ApplicationController
  def new
    # Note: Use of logged_in? here in place of
    # redirect_if_not_logged_in because this action
    # requires the opposite result

    # logged_in? found in SessionsHelper
    if logged_in?
      redirect_to current_logged_in_user
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        remember(@user) if (params[:session][:remember_me] == "1")
        log_in @user
        redirect_to @user
      else
        message = "Account not activated. Please check your email for the activation link."
        flash[:warning] = message
        redirect_to root_path
      end
    else
      flash.now[:danger] = "Invalid email/password. Try again."
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
