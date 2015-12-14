module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    def log_out
        session[:user_id] = nil
        @current_logged_in_user = nil
    end

    # Returns current logged in user (if any)
    def current_logged_in_user
        # Use find_by instead of find, as find throws
        # exception if session[:user_id] == nil
        @current_logged_in_user ||= User.find_by(id: session[:user_id])
    end

    # Compares the currently logged in user
    # with another User
    def current_logged_in_user_is?(other_user)
        return current_logged_in_user == other_user
    end

    # Checks if current user exists
    def logged_in?
        !current_logged_in_user.nil?
    end

    # Checks if user is logged in
    def is_logged_in?
        unless logged_in?
            flash[:danger] = "Please log in."
            redirect_to root_path
        end
    end

    # Checks if user is authorized to access page
    def is_authorized_user?
        @user = User.friendly.find(params[:user_id]) || User.friendly.find(params[:id])
        unless current_logged_in_user_is?(@user)
            flash[:danger] = "Please log in as correct user."
            redirect_to current_logged_in_user
        end
    end
end
