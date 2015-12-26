class FriendshipsController < ApplicationController
    # redirect_if_not_logged_in is found in SessionsHelper
    before_action :redirect_if_not_logged_in, only: [:create, :destroy]

    def create
        user = User.find(params[:friend_id])
        current_logged_in_user.befriend(user)
        flash[:success] = "Successfully befriended #{user.name}!"
        redirect_to current_logged_in_user
    end

    def destroy
        user = Friendship.find(params[:id]).friend
        current_logged_in_user.unfriend(user)
        flash[:success] = "You have unfriended #{user.name}."
        redirect_to current_logged_in_user
    end
end
