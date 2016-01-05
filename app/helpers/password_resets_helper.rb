module PasswordResetsHelper
  private
    def check_password_reset_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset link expired."
        redirect_to new_password_reset_path
      end
    end

    def get_user_from_email_in_params
      @user = User.find_by(email: params[:email])
    end

    def password_reset_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def is_valid_user?
      unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
        flash[:warning] = "Unauthorized access."
        redirect_to root_path
      end
    end
end
