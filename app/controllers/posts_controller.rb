class PostsController < ApplicationController
  include PostsHelper
  # redirect_if_not_logged_in is found in SessionsHelper
  before_action :redirect_if_not_logged_in, only: [:create, :destroy]
  # is_correct_user_for_post? is found in PostsHelper
  before_action :is_correct_user_for_post?, only: :destroy

  def create
    @post = @current_logged_in_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      Pusher['post_channel'].trigger('post', {
        :poster_name => @post.user.name
      })
    else
      flash[:danger] = "Failed to create post."
    end
    redirect_to user_group_path(user_id: @current_logged_in_user.slug, id: Group.find(params[:post][:group_id]).slug)
  end

  def destroy
    @post.destroy!
    flash[:success] = "Post destroyed."
    redirect_to user_group_path(user_id: @current_logged_in_user.slug, id: params[:group_slug])
  end
end
