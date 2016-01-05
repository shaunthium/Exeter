module GroupsHelper
  # Strong params for Group name
  def group_params
    params.require(:group).permit(:name)
  end

  # Returns group from slug in params[:id]
  def get_current_group_from_slug_in_id
    @group = Group.friendly.find(params[:id])
  end

  # Returns group from slug in params[:group_slug]
  def get_current_group_from_slug_in_group_slug
    @group = Group.friendly.find(params[:group_slug])
  end
end
