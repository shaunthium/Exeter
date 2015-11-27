module UsersHelper
    # Strong params
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    # Checks if user is authorized to view page
    def is_authorized_user?
        @user = User.find(params[:id])
        unless current_logged_in_user_is?(@user)
            flash[:danger] = "Please log in as correct user."
            redirect_to current_logged_in_user
        end
    end

    # Befriends other User
    def befriend(other_user)
        friendships.create(friend_id: other_user.id)
        other_user.friendships.create(friend_id: id)
    end

    # Unfriends other User
    def unfriend(other_user)
        friendships.find_by(friend_id: other_user.id).destroy
        other_user.friendships.find_by(friend_id: id).destroy
    end

    # Returns true if user is friends with other User
    def is_friends_with?(other_user)
        friends.include?(other_user)
    end

    # Returns user's feed
    def feed
        friends_ids = "SELECT friend_id FROM friendships WHERE user_id = :self_id"
        Post.where("user_id IN (#{friends_ids}) OR user_id = :self_id", self_id: id)
    end
end
