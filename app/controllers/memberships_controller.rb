class MembershipsController < ApplicationController
    include MembershipsHelper, GroupsHelper, UsersHelper

    # is_logged_in? is found in SessionsHelper
    before_action :is_logged_in?
    # get_current_group_from_slug_in_group_slug is found in MembershipsHelper
    before_action :get_current_group_from_slug_in_group_slug, only: [:create, :destroy]

    def new
        @membership = Membership.new
        @members = members_to_add
        @group_slug = params[:group_slug]
    end

    def create
        @member_slugs = params[:members]
        @member_slugs.each do |key, value|
            User.friendly.find(key).add_to_group(@group)
        end
        flash[:success] = "Successfully added friends to groups!"
        redirect_to user_group_path(user_id: @current_logged_in_user.slug, id: @group.slug)
    end

    def remove
        @group_slug = params[:group_slug]
        @members = added_friends
    end

    def destroy
        @member_slugs = params[:members]
        @member_slugs.each do |key, value|
            User.friendly.find(key).remove_from_group(@group)
        end
        flash[:success] = "Successfully removed friends from groups."
        redirect_to user_group_path(user_id: @current_logged_in_user.slug, id: @group.slug)
    end
end
