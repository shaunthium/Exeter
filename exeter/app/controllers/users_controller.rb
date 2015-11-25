class UsersController < ApplicationController
    include UsersHelper

    # is_logged_in? is found in ApplicationController
    before_action :is_logged_in?, only: [:show, :edit, :update]
    # is_correct_user? is found in UsersHelper
    before_action :is_correct_user?, only: [:show, :edit, :update]

    def show
        @posts = @user.posts.all
        @post = @user.posts.build
    end

    def new
        if logged_in?
            redirect_to current_user
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
    end

    def update
        if @user.update_attributes(user_params)
            flash[:success] = "Information successfully updated"
            redirect_to @user
        else
            render 'edit'
        end
    end
end
