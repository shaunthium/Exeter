module SessionsHelper
    # Stores user id using Rails' sessions method
    def log_in(user)
        session[:user_id] = user.id
    end

    # Clears session
    def log_out
        forget(current_logged_in_user)
        session[:user_id] = nil
        @current_logged_in_user = nil
    end

    # Remembers user for persistent session
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    # Deletes user's persistent session
    def forget(user)
        user.forget
        cookies[:user_id] = nil
        cookies[:remember_token] = nil
    end

    # Returns current logged in user (if any)
    def current_logged_in_user
        if (user_id = session[:user_id])
            # Use find_by instead of find, as find throws
            # exception if session[:user_id] == nil
            @current_logged_in_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_logged_in_user = user
            end
        end
    end

    # Compares the currently logged in user
    # with another User
    def current_logged_in_user_is?(other_user)
        current_logged_in_user == other_user
    end

    # Checks if current user exists
    def logged_in?
        !current_logged_in_user.nil?
    end

    # Checks if user is logged in
    def redirect_if_not_logged_in
        unless logged_in?
            flash[:danger] = "Please log in."
            redirect_to root_path
        end
    end

    # Checks if current_logged_in_user is the same
    # user as on page
    def redirect_if_current_logged_in_user_is_not_user_on_page
        if params[:user_id]
            @user = User.friendly.find(params[:user_id])
        else
            @user = User.friendly.find(params[:id])
        end

        unless current_logged_in_user_is?(@user)
            flash[:danger] = "Please log in as correct user."
            redirect_to current_logged_in_user
        end
    end
end
