module MembershipsHelper
    # Returns ActiveRelation of all of user's friends
    def all_friends_ids
        "SELECT friend_id FROM friendships WHERE user_id = :user_id"
    end

    def all_group_members_ids
        "SELECT member_id FROM memberships WHERE group_id = :group_id"
    end

    def all_group_admins_ids
        "SELECT admin_id FROM adminships WHERE administrated_group_id = :group_id"
    end

    # Returns either ActiveRelation or IDs of all of
    # user's friends which have been added into the group
    def added_friends_or_friends_ids(get_ids=false)
        added_friends_ids = "SELECT member_id FROM memberships WHERE group_id = :group_id"
        if get_ids
            added_friends_ids
        else
            User.where("(id IN (#{added_friends_ids}))", group_id: get_current_group_from_slug_in_group_slug.id).where.not("id = ?", current_logged_in_user.id)
        end
    end

    def members_to_add
        User.where("(id IN (#{all_friends_ids})) AND (id NOT IN (#{added_friends_or_friends_ids(get_ids=true)}))", user_id: current_logged_in_user.id, group_id: get_current_group_from_slug_in_group_slug.id)
    end

    def members_to_make_admin
        User.where("(id IN (#{all_group_members_ids}))
        AND (id NOT IN (#{all_group_admins_ids}))", group_id: get_current_group_from_slug_in_id.id)
    end
end
