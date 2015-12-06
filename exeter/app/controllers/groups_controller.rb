class GroupsController < ApplicationController
    include GroupsHelper

    # is_logged_in? is found in ApplicationController
    before_action :is_logged_in?
    before_action :get_max_group_id, only: :create

    def index
    end

    def new
        @group = Group.new
        @user = current_logged_in_user
    end

    def create
        @user = current_logged_in_user
        @group = Group.new(name: group_params[:name], member_id: @user.id, group_id: @group_id)
        if @group.save
            flash[:success] = "Group successfully created!"
            redirect_to @group
        else
            flash[:danger] = "Failed to create group."
            render 'new'
            @group = Group.new
            @user = current_logged_in_user
        end
    end

    def show
        @group = Group.find(params[:id])
        @members_groups = Group.where(group_id: params[:id])
    end

    def edit
        @group = Group.find(params[:id])
        @friends = current_logged_in_user.friends
    end

    def update
        group_to_update = Group.find(params[:id])
        @friend_ids = params[:friend]
        @friend_ids.each do |key, value|
            group_to_add = Group.create(group_id: group_to_update.id, name: group_to_update.name, member_id: key.to_i)
        end
        flash[:success] = "Updated group successfully!"
        redirect_to current_logged_in_user
    end

    def destroy
    end
end
