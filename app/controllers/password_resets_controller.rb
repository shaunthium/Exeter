class PasswordResetsController < ApplicationController
    def new
    end

    def create
      user = User.find_by(email: params[:password_reset][:email].downcase)
      if user
          user.create_reset_digest
          user.send_password_reset_email
          flash[:info] = "Successfully sent password reset email!"
          redirect_to root_path
      else
          flash.now[:warning] = "Email not found. Please try again."
          render 'new'
      end
    end

    def edit
    end
end
