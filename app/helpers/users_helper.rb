module UsersHelper
  private
    # Strong params
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture)
    end
end
