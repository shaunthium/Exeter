class MembershipsController < ApplicationController
    include MembershipsHelper
    include GroupsHelper
    include UsersHelper

    # is_logged_in? is found in SessionsHelper
    before_action :is_logged_in?
    # get_current_group found in MembershipsHelper
    before_action :get_current_group_from_group_id, only: [:create, :destroy]

    def new
        @membership = Membership.new
        @members = members_to_add
        @group_id = params[:group_id]
    end

    def create
        @member_ids = params[:members]
        @member_ids.each do |key, value|
            User.find(key).add_to_group(@group)
        end
        flash[:success] = "Successfully added friends to groups!"
        redirect_to user_group_path(user_id: @current_logged_in_user, id: @group)
    end

    def remove
        @group_id = params[:group_id]
        @members = added_friends_ids(remove=true)
    end

    def destroy
        @member_ids = params[:members]
        @member_ids.each do |key, value|
            User.find(key).remove_from_group(@group)
        end
        flash[:success] = "Successfully removed friends from groups."
        redirect_to user_group_path(user_id: @current_logged_in_user, id: @group)
    end
end
