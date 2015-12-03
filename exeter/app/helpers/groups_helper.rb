module GroupsHelper
    def group_params
        params.require(:group).permit(:name)
    end

    def get_max_group_id
        current_max_group_id = Group.maximum(:group_id)
        if current_max_group_id == nil
            current_max_group_id = 0
        end
        @group_id = current_max_group_id.to_i + 1
    end
end
