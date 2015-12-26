class GroupsController < ApplicationController
    include GroupsHelper, MembershipsHelper, AdminshipsHelper

    # redirect_if_not_logged_in is found in SessionsHelper
    before_action :redirect_if_not_logged_in
    # get_current_group_from_slug_in_id is found in GroupsHelper
    before_action :get_current_group_from_slug_in_id, only: [:show, :edit, :update, :destroy]
    # is_admin? is found in AdminshipsHelper
    before_action only: [:edit, :update, :destroy] do
        is_admin?(get_current_group_from_slug_in_id)
    end

    def index
    end

    def new
        @group = Group.new
    end

    def create
        @group = Group.new(group_params)
        if @group.save
            flash[:success] = "Group successfully created!"
            current_logged_in_user.add_to_group(@group)
            current_logged_in_user.make_admin_of_group(@group)

            redirect_to user_group_path(user_id: current_logged_in_user.slug, id: @group.slug)
        else
            render 'new'
        end
    end

    def show
        @members = @group.members.all
        @group_admins = @group.admins
        @user = current_logged_in_user
        @new_post = @user.posts.build(group_id: @group.id)
        @feed = feed
    end

    def edit
        @user_slug = current_logged_in_user.slug
        @members = members_to_make_admin
    end

    def update
        @user_slug = current_logged_in_user.slug
        @group.slug = nil
        if @group.update_attributes(group_params)
            @members_slugs = params[:members]
            unless @members_slugs.nil?
                @members_slugs.each do |name, slug|
                    User.friendly.find(slug).make_admin_of_group(@group)
                end
            end
            flash[:success] = "Updated group successfully!"
            redirect_to user_group_path(user_id: @user_slug, id: @group.slug)
        else
            render 'edit'
        end
    end

    def destroy
        @group.destroy
        flash[:success] = "Successfully deleted group."
        redirect_to user_path(current_logged_in_user)
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
