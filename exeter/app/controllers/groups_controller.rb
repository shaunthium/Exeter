class GroupsController < ApplicationController
    include GroupsHelper

    # is_logged_in? is found in ApplicationController
    before_action :is_logged_in?

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
            flash[:danger] = "Failed to create group."
            render 'new'
            @group = Group.new
        end
    end

    def show
        @group = Group.find(params[:id])
        @members = @group.members.all
        @user = current_logged_in_user
    end

    def edit
        # For deciding if group should add or remove members
        @view = params[:view]
        @group = Group.find(params[:id])
        @user = current_logged_in_user

        if @view == "add"
            @friends_to_add = []
            users_friends.each do |f|
                unless added_friends.exists?(f.id)
                    @friends_to_add << f
                end
            end
        else
            @friends_to_remove = added_friends(remove=true)
        end
    end

    def update
        curr_group = Group.find(params[:id])
        @friend_ids = params[:friend]
        @friend_ids.each do |key, value|
            if params[:add] == "true"
                Group.create(group_id: curr_group.group_id, name: curr_group.name, member_id: key.to_i)
            else
                Group.find_by(group_id: curr_group.group_id, member_id: key.to_i).destroy
            end
        end
        flash[:success] = "Updated group successfully!"
        redirect_to user_group_path(user_id: current_logged_in_user.id, id: curr_group.id)
    end

    def destroy
    end
end
