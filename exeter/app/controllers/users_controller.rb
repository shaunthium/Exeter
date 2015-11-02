class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
    end

    def new
        if logged_in?
            redirect_to @current_user
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

    def edit
        @user = User.find(params[:id])
    end

    def update
        user = User.find(params[:id])

        if user.update_attributes(user_params)
            redirect_to user
        else
            redirect_to edit_user_path
        end
    end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password,
                                            :password_confirmation)
        end
end
