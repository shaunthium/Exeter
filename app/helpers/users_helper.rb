module UsersHelper
    # Strong params
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Befriends other User
    def befriend(other_user)
        friendships.create!(friend_id: other_user.id)
        other_user.friendships.create!(friend_id: id)
    end

    # Unfriends other User
    def unfriend(other_user)
        friendships.find_by(friend_id: other_user.id).destroy!
        other_user.friendships.find_by(friend_id: id).destroy!
    end

    # Returns true if user is friends with other User
    def is_friends_with?(other_user)
        friends.include?(other_user)
    end

    # Adds member to group
    def add_to_group(group)
        memberships.create(group_id: group.id)
    end

    # Removes member from group
    def remove_from_group(group)
        memberships.find_by(group_id: group.id).destroy!
    end

    # Makes user admin of group
    def make_admin_of_group(group)
        adminships.create(administrated_group_id: group.id)
    end
end
