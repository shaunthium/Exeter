class PostsController < ApplicationController
  include PostsHelper, NotificationsHelper
  # redirect_if_not_logged_in is found in SessionsHelper
  before_action :redirect_if_not_logged_in, only: [:create, :destroy]
  # is_correct_user_for_post? is found in PostsHelper
  before_action :is_correct_user_for_post?, only: :destroy

  def create
    @post = current_logged_in_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      group = @post.group
      action = "created a post"
      notify_members_of_group(group, action)
      # TO-DO: Remove test code below
      # Pusher['post_channel'].trigger('post', {
      #   :poster_name => @post.user.name
      # })
    else
      flash[:danger] = "Failed to create post."
    end
    redirect_to user_group_path(user_id: @current_logged_in_user.slug, id: Group.find(params[:post][:group_id]).slug)
  end

  def destroy
    group = @post.group
    action = "deleted a post"
    notify_members_of_group(group, action)
    @post.destroy!
    flash[:success] = "Post destroyed."
    redirect_to user_group_path(user_id: @current_logged_in_user.slug, id: params[:group_slug])
  end
end
