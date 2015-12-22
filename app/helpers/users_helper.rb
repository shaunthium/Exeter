module UsersHelper
    # Strong params
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Returns hash digest of given string
    # Class method, as no need for a user instance
    def User.digest(string)
        BCrypt::Password.create(string)
    end

    # Returns url-safe base-64 token
    # Class method, as no need for a user instance
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # Remembers user for persistent session
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(self.remember_token))
    end

    # Forgets user for persistent session
    def forget
        update_attribute(:remember_digest, nil)
    end

    # Checks if given token matches digest
    def authenticated?(remember_token)
        return false if self.remember_digest.nil?
        BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
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
