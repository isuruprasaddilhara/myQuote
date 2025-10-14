class SessionsController < ApplicationController

  def new
    # renders sign-in form
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) && user.status == "Active"
      session[:user_id] = user.id
      session[:fname] = user.fname
      session[:is_admin] = user.is_admin
      if session[:is_admin]
        redirect_to admin_path, notice: "Logged in successfully!"
      else
        redirect_to userhome_path, notice: "Logged in successfully!"
      end
    else
      flash.now[:alert] = "Invalid email or password. Please try again."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out successfully!"
  end
end
