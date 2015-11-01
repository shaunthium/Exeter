class SessionsController < ApplicationController
  def new
      if logged_in?
          redirect_to user_path(@current_user)
      end
  end

  def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
          log_in user
          redirect_to user
      else
          redirect_to login_path
      end
  end

  def delete
      log_out
      redirect_to root_url
  end
end
