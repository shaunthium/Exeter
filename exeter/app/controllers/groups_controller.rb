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

    def edit
    end

    def show
        @group = Group.find(params[:id])
    end

    def update
    end

    def destroy
    end
end
