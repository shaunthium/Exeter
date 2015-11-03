class UsersController < ApplicationController
    include UsersHelper

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
        @user = User.new(user_params)

        if @user.save
            log_in @user
            redirect_to @user
        else
            render 'new'
            @user = User.new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])

        if @user.update_attributes(user_params)
            redirect_to @user
        else
            render 'edit'
        end
    end
end
