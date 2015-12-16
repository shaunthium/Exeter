class GroupsController < ApplicationController
    include GroupsHelper

    # is_logged_in? is found in SessionsHelper
    before_action :is_logged_in?
    # is_authorized_user? is found in SessionsHelper
    before_action :is_authorized_user?
    # get_current_group_from_id is found in GroupsHelper
    before_action :get_current_group_from_id, only: [:show, :edit, :update, :destroy]

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
            redirect_to user_group_path(user_id: @current_logged_in_user.slug, id: @group.slug)
        else
            render 'new'
        end
    end

    def show
        @members = @group.members.all
        @user = @current_logged_in_user
        @new_post = @user.posts.build(group_id: @group.id)
        @feed = feed
    end

    def edit
        @user_slug = @current_logged_in_user.slug
    end

    def update
        @user_slug = @current_logged_in_user.slug
        if @group.update_attributes(group_params)
            flash[:success] = "Updated group successfully!"
            redirect_to user_group_path(user_id: @user_slug, id: @group.slug)
        else
            render 'edit'
        end
    end

    def destroy
        @group.destroy
        flash[:success] = "Successfully deleted group."
        redirect_to user_path(@current_logged_in_user)
    end

    private
        # Returns user's feed.
        # Note: Not in GroupsHelper, as group_id is needed from params[:id]
        # and params method can't be accessed from helpers
        def feed
            members_ids = "SELECT member_id FROM memberships WHERE group_id = :group_id"
            Post.where("(user_id IN (#{members_ids})) AND (group_id = :group_id)", group_id: @group)
        end
end
