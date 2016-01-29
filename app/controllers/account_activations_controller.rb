class AccountActivationsController < ApplicationController
  def verify
    user = User.find_by(email: params[:email])
    if user && !user.activated && user.authenticated?(:activation, params[:id])
      # Use of 2 update_attribute calls instead of update_columns
      # to prevent potential problems with updated_at not being updated properly
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = "Your account has been successfully activated!"
      redirect_to user
    else
        flash[:danger] = "Invalid activation link"
        redirect_to root_path
    end
  end
end
