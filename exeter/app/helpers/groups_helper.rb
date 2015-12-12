module GroupsHelper
    # Returns group id from group id
    def get_current_group_from_group_id
        @group = Group.find(params[:group_id])
    end

    # Returns group id from id
    def get_current_group_from_id
        @group = Group.find(params[:id])
    end

    # Strong params for Group name
    def group_params
        params.require(:group).permit(:name)
    end

    # Returns user's feed
    def feed
        friends_ids = "SELECT friend_id FROM friendships WHERE user_id = :self_id"
        Post.where("user_id IN (#{friends_ids}) OR user_id = :self_id", self_id: id)
    end
end
