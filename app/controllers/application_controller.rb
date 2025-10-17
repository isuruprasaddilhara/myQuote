class ApplicationController < ActionController::Base
    # These methods are made available to views as well as controllers:
    # current_user: gets the user who is currently logged in.
    # logged_in?: tells us whether a user is logged in or not.
    # is_administrator?: checks if the logged-in user is an admin.
    helper_method :current_user, :logged_in?, :is_administrator?

    # Returns the currently logged-in user based on the session.
    # Memoizes the result so we only hit the database once per request.
    # If nobody is logged in, it returns nil.
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    # Returns true if a user is logged in, false if not.
    # Basically just checks whether current_user exists.
    def logged_in?
        !current_user.nil?
    end

    # Returns true if the current user is an administrator.
    # This is determined by the value stored in the session when the user logs in.
    def is_administrator?
        session[:is_admin]
    end      

private
    # This method is used as a filter to make sure certain pages are only accessible to logged-in users. If someone tries to access a page without being logged in.
    # 1. They get a friendly error message.
    # 2. They are redirected to the login page.
    # It's a simple way to protect sensitive parts of the app.
    def require_login
        unless logged_in?
        flash[:error] = "You are not permitted to access this resource"
        redirect_to login_path
        end
    end

end