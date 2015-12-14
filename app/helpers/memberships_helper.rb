module MembershipsHelper
    # Returns ActiveRelation of all of user's friends
    def all_friends_ids
        "SELECT friend_id FROM friendships WHERE user_id = :user_id"
    end

    # Returns ActiveRelation of all of user's friends
    # which have been added into the group
    def added_friends(get_ids=false)
        added_friends_ids = "SELECT member_id FROM memberships WHERE group_id = :group_id"
        if get_ids
            added_friends_ids
        else
            User.where("(id IN (#{added_friends_ids}))", group_id: params[:group_id]).where.not("id = ?", current_logged_in_user.id)
        end
    end

    def members_to_add
        members_to_add = User.where("(id IN (#{all_friends_ids})) AND (id NOT IN (#{added_friends(get_ids=true)}))", user_id: current_logged_in_user.id, group_id: params[:group_id])
    end
end
