class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    include SessionsHelper

    # Checks if user is logged in
    def is_logged_in?
        # logged_in? found in SessionsHelper
        unless logged_in?
            flash[:danger] = "Please log in."
            redirect_to root_url
        end
    end
end
