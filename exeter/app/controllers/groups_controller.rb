class GroupsController < ApplicationController
    include GroupsHelper

    # is_logged_in? is found in SessionsHelper
    before_action :is_logged_in?
    # is_authorized_user? is found in SessionsHelper
    before_action :is_authorized_user?, except: :show

    def index
    end

    def new
        @group = Group.new
        @user = current_logged_in_user
    end

    def create
        @group = Group.new(group_params)
        if @group.save
            flash[:success] = "Group successfully created!"
            current_logged_in_user.memberships.create(group_id: @group.id)
            redirect_to user_group_path(user_id: current_logged_in_user.id, id: @group.id)
        else
            render 'new'
        end
    end

    def show
        @group = Group.find(params[:id])
        @members = @group.members.all
        @user = current_logged_in_user
    end

    def edit
        @group = Group.find_by(id: params[:id])
        @user_id = current_logged_in_user.id
    end

    def update
        @group = Group.find_by(id: params[:id])
        @user_id = current_logged_in_user.id
        if @group.update_attributes(group_params)
            flash[:success] = "Updated group successfully!"       
            redirect_to user_group_path(user_id: @user_id, id: @group)
        else
            render 'edit'
        end
    end

    def destroy
        Group.find_by(id: params[:id]).destroy
        flash[:success] = "Successfully deleted group."
        redirect_to user_path(current_logged_in_user.id)
    end
end
