class GroupsController < ApplicationController
    include GroupsHelper

    # is_logged_in? is found in ApplicationController
    before_action :is_logged_in?
    before_action :get_max_group_id, only: :create

    def index
    end

    def new
        @group = Group.new
    end

    def create
        @group = Group.new(name: group_params[:name], member_id: current_logged_in_user.id, group_id: @group_id)
        if @group.save
            flash[:success] = "Group successfully created!"
            redirect_to @group
        else
            flash[:danger] = "Failed to create group."
            render 'new'
            @group = Group.new
        end
    end

    def show
        @group = Group.find(params[:id])
        @members_groups = Group.where(group_id: params[:id])
    end

    def edit
        # For deciding if group should add or remove members
        @view = params[:view]
        @group = Group.find(params[:id])

        user_friends = get_users_friends
        added_friends = get_added_friends

        @friends_to_add = []
        user_friends.each do |f|
            unless added_friends.exists?(f.id)
                @friends_to_add << f
            end
        end
    end

    def update
        curr_group = Group.find(params[:id])
        @friend_ids = params[:friend]
        @friend_ids.each do |key, value|
            Group.create(group_id: curr_group.id, name: curr_group.name, member_id: key.to_i)
        end
        flash[:success] = "Updated group successfully!"
        redirect_to curr_group
    end

    def destroy
    end
end
