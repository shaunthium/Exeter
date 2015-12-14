class SessionsController < ApplicationController
  def new
      # Note: Use of logged_in? here in place of
      # is_logged_in? because this action requires
      # opposite result from is_logged_in?

      # logged_in? found in SessionsHelper
      if logged_in?
          redirect_to current_logged_in_user
      end
  end

  def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
          log_in user
          redirect_to user
      else
          flash.now[:danger] = "Invalid email/password. Try again."
          render 'new'
      end
  end

  def destroy
      log_out
      redirect_to root_path
  end
end
