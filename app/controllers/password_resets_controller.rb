class PasswordResetsController < ApplicationController
    include PasswordResetsHelper

    # get_user_from_email_in_params is found in PasswordResetsHelper
    before_action :get_user_from_email_in_params, only: [:edit, :update]
    # is_valid_user? is found in PasswordResetsHelper
    before_action :is_valid_user?, only: [:edit, :update]

    def new
    end

    def create
      @user = User.find_by(email: params[:password_reset][:email].downcase)
      if @user
          @user.create_reset_digest
          @user.send_password_reset_email
          flash[:info] = "Successfully sent password reset email!"
          redirect_to root_path
      else
          flash.now[:warning] = "Email not found. Please try again."
          render 'new'
      end
    end

    def edit
    end

    def update
        if params[:user][:password].empty?
            @user.errors.add(:password, "can't be empty")
            render 'edit'
        elsif @user.update_attributes(password_reset_params)
            log_in @user
            flash[:success] = "Password has been successfully reset."
            redirect_to @user
        else
            render 'edit'
        end
    end
end
