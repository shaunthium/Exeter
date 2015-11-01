class UsersController < ApplicationController
    def new
        if logged_in?
            redirect_to user_path(@current_user)
        else
            @user = User.new
        end
    end

    def create
        user = User.new(user_params)

        if user.save
            log_in user
            redirect_to user
        else
            redirect_to root_url
        end
    end

    def show
        @user = User.find(params[:id])
    end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password,
                                            :password_confirmation)
        end
end
