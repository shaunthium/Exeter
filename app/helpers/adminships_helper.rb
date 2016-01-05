module AdminshipsHelper
  def is_admin?(group)
    user = current_logged_in_user
    unless group.admins.include?(user)
      flash[:danger] = "Please log in as administrator."
      redirect_to root_path
    end
  end
end
