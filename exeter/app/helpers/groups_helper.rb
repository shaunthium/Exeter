module GroupsHelper
    # Strong params for Group name
    def group_params
        params.require(:group).permit(:name)
    end

    # Returns the current largest maximum group id and
    #increments it by 1.
    def get_max_group_id
        current_max_group_id = Group.maximum(:group_id)
        if current_max_group_id == nil
            current_max_group_id = 0
        end
        @group_id = current_max_group_id.to_i + 1
    end

    # Returns ActiveRelation of all of user's friends
    def users_friends
        users_friend_ids = "SELECT friend_id FROM friendships WHERE user_id = :user_id"
        users_friends = User.where("id IN (#{users_friend_ids})", user_id: current_logged_in_user)
    end

    # Returns ActiveRelation of all of user's friends
    # which have been added into the group
    def added_friends(remove=false)
        user_ids = "SELECT member_id FROM groups WHERE group_id = :group_id"
        added_friends = User.where("id IN (#{user_ids})", group_id: params[:id])
        if remove
            added_friends = added_friends.where.not(id: current_logged_in_user.id)
        end
        added_friends
    end
end
