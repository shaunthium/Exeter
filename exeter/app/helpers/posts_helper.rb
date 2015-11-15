module PostsHelper
    def post_params
        params.require(:post).permit(:content)
    end

    def correct_user
        @post = @current_user.posts.find_by(id: params[:id])
        redirect_to root_url if @post.nil?
    end
end
