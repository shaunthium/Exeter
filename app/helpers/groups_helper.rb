module GroupsHelper
    # Returns group id from group id
    def get_current_group_from_group_id
        @group = Group.friendly.find(params[:group_id])
    end

    # Returns group id from id
    def get_current_group_from_id
        @group = Group.friendly.find(params[:id])
    end

    # Strong params for Group name
    def group_params
        params.require(:group).permit(:name)
    end
end
