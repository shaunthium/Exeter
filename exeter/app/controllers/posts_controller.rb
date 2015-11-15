class PostsController < ApplicationController
    include PostsHelper
    before_action :is_logged_in?, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @post = @current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "Post created!"
            redirect_to @current_user
        else
            flash[:danger] = "Failed :("
        end
    end

    def destroy
        @post.destroy
        flash[:success] = "Post destroyed."
    end
end
