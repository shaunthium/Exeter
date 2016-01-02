class MembershipsController < ApplicationController
    include MembershipsHelper, GroupsHelper, AdminshipsHelper

    # redirect_if_not_logged_in is found in SessionsHelper
    before_action :redirect_if_not_logged_in
    # get_current_group_from_slug_in_group_slug is found in GroupsHelper
    before_action :get_current_group_from_slug_in_group_slug, only: [:create, :destroy]
    # is_admin? is found in AdminshipsHelper
    before_action do
        is_admin?(get_current_group_from_slug_in_group_slug)
    end

    def new
        @membership = Membership.new
        @members = members_to_add
        @group_slug = params[:group_slug]
    end

    def create
        @members_slugs = params[:members]
        @members_slugs.each do |name, slug|
            User.friendly.find(slug).add_to_group(@group)
        end
        flash[:success] = "Successfully added members to group!"
        redirect_to user_group_path(user_id: current_logged_in_user.slug, id: @group.slug)
    end

    def remove
        @group_slug = params[:group_slug]
        @members = added_friends_or_friends_ids
    end

    def destroy
        @member_slugs = params[:members]
        @member_slugs.each do |name, slug|
            User.friendly.find(slug).remove_from_group(@group)
        end
        flash[:success] = "Successfully removed members from groups."
        redirect_to user_group_path(user_id: current_logged_in_user.slug, id: @group.slug)
    end
end
