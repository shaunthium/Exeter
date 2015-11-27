class UsersController < ApplicationController
    include UsersHelper

    # is_logged_in? is found in ApplicationController
    before_action :is_logged_in?, only: [:show, :edit, :update]
    # is_authorized_user? is found in UsersHelper
    before_action :is_authorized_user?, only: [:edit, :update]

    def index
        @all_users = User.all
    end

    def show
        @user = User.find(params[:id])
        @all_posts = @user.posts.all
        @new_post = @user.posts.build
        @feed = @user.feed
    end

    def new
        if logged_in?
            redirect_to current_logged_in_user
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
