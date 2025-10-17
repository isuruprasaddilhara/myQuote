# SessionsController manages user login and logout functionality.
# It handles creating a session when a user logs in and clearing it when they log out.
class SessionsController < ApplicationController

  def new
    # renders sign-in form
  end

  # POST /login
  # Handles the login process when the user submits their email and password.
  # It verifies user credentials, checks account status, and establishes a session.
  def create
    # Find the user record by the email address entered in the login form.
    user = User.find_by(email: params[:email])
    # Authenticate the user by verifying their password and ensuring their account is active.
    # If authentication is successful, a session is created.
    if user && user.authenticate(params[:password]) && user.status == "Active"
      session[:user_id] = user.id
      session[:fname] = user.fname
      session[:is_admin] = user.is_admin
      # Redirect the user based on their role:
      # - Admin users are redirected to the admin dashboard.
      # - Regular users are redirected to their home page.
      if session[:is_admin]
        redirect_to admin_path, notice: "Logged in successfully!"
      else
        redirect_to userhome_path, notice: "Logged in successfully!"
      end
    else
       # If login fails (invalid credentials or inactive account):
      # - Display an alert message on the same page.
      # - Re-render the login form without clearing the input fields.
      flash.now[:alert] = "Invalid email or password. Please try again."
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /logout
  # Logs the user out by clearing all session data.
  # After logout, the user is redirected to the home page with a confirmation message.
  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out successfully!"
  end
end
