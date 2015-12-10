class PostsController < ApplicationController
    include PostsHelper
    # is_logged_in? is found in SessionsHelper
    before_action :is_logged_in?, only: [:create, :destroy]
    # is_correct_user_for_post? is found in PostsHelper
    before_action :is_correct_user_for_post?, only: :destroy

    def create
        @post = current_logged_in_user.posts.build(post_params)
        if @post.save
            flash[:success] = "Post created!"
        else
            flash[:danger] = "Failed :("
        end
        redirect_to @current_logged_in_user
    end

    def destroy
        @post.destroy
        flash[:success] = "Post destroyed."
        redirect_to current_logged_in_user
    end
end
