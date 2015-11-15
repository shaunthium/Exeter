module UsersHelper
    # Strong params
    def user_params
        params.require(:user).permit(:name, :email, :password,
                                        :password_confirmation)
    end
    #
    # Checks if user is authorized to view page
    def is_correct_user?
        @user = User.find(params[:id])
        unless @user == current_user
            flash[:danger] = "Please log in as correct user."
            redirect_to current_user
        end
    end
end
