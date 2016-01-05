module PostsHelper
  # Strong params for Posts
  def post_params
    params.require(:post).permit(:content, :group_id)
  end

  # Checks if user is authorized to delete post
  def is_correct_user_for_post?
    @post = current_logged_in_user.posts.find_by(id: params[:id])
    redirect_to current_logged_in_user if @post.nil?
  end
end
