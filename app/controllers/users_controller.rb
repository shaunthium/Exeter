class UsersController < ApplicationController
    include UsersHelper

    # is_logged_in? is found in SessionsHelper
    before_action :is_logged_in?, except: [:new, :create]
    # is_authorized_user? is found in SessionsHelper
    before_action :is_authorized_user?, only: [:edit, :update, :destroy, :friends]

    def index
        @all_users = User.all
    end

    def show
        @user = User.friendly.find(params[:id])
        @groups = current_logged_in_user.groups.all
    end

    def new
        if logged_in?
            redirect_to current_logged_in_user
        else
            @user = User.new
        end
    end

    # Unsuccessful user creation handled by error_messages partial
    def create
        @user = User.new(user_params)
        if @user.save
            log_in @user
            redirect_to @user
        else
            render 'new'
        end
    end

    def edit
    end

    # Unsuccessful update handled by error_messages partial
    def update
        @current_logged_in_user.slug = nil
        if @current_logged_in_user.update_attributes(user_params)
            flash[:success] = "Information successfully updated!"
            redirect_to @current_logged_in_user
        else
            @user = @current_logged_in_user
            render 'edit'
        end
    end

    def friends
        user = User.friendly.find(params[:user_id])
        @friends = user.friends
    end

    def groups
        @groups = Group.where(member_id: current_logged_in_user.id)
    end

    def destroy
        friends = @current_logged_in_user.friends.all
        friends.each do |f|
            @current_logged_in_user.unfriend(f)
        end
        @current_logged_in_user.destroy!
        flash[:success] = "User successfully removed."
        redirect_to root_path
    end
end
