class MembershipsController < ApplicationController
    include MembershipsHelper

    # is_logged_in? is found in SessionsHelper
    before_action :is_logged_in?

    def new
        @membership = Membership.new
        @members = members_to_add
        @group_id = params[:group_id]
    end

    def create
        @member_ids = params[:member]
        @group_id = params[:group_id]
        @member_ids.each do |key, value|
            User.find(key).memberships.create(group_id: @group_id)
        end
        flash[:success] = "Successfully added friends to groups!"
        redirect_to user_group_path(user_id: current_logged_in_user.id, id: @group_id)
    end

    def remove
        @group = Group.find(params[:group_id])
        @members = added_friends_ids(remove=true)
    end

    def destroy
        @member_ids = params[:member]
        @group_id = params[:group_id]
        @member_ids.each do |key, value|
            User.find(key).memberships.find_by(group_id: @group_id).destroy
        end
        flash[:success] = "Successfully removed friends from groups."
        redirect_to user_group_path(user_id: current_logged_in_user.id, id: @group_id)
    end
end
