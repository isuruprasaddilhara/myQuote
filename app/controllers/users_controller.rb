# UsersController manages all user-related operations such as
# registration, viewing profiles, editing details, and deleting accounts.
# It ensures secure access control by requiring users to be logged in
# for specific actions while allowing new registrations freely.
class UsersController < ApplicationController
  # Before performing certain actions, the set_user method is called to find the user record based on the provided ID parameter.
  before_action :set_user, only: %i[ show edit update destroy ]
  # Ensures that only logged-in users can access sensitive actions. New users can still access the registration page.
  before_action :require_login, except: [:new, :create] 

  # GET /users
  # Retrieves and displays a list of all users in the system.
  # This is typically accessible only to admin users.
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  # Initializes a new User object for the registration form.
  # Used to render the sign-up page where users can create an account.
  def new
    @user = User.new
  end

   # GET /users/:id/edit
  # Displays the edit form for updating an existing user's details.
  # The @user record is retrieved by the set_user callback.
  def edit
  end

  # POST /users
  # Handles user registration by saving a new user record to the database.
  # If successful, redirects the user to the login page.
  # If not, re-renders the registration form with validation errors
  def create
    @user = User.new(user_params)
    @user.status = "Active"
    respond_to do |format|
      if @user.save
        # Redirects to the login page after successful registration.
        format.html { redirect_to login_path, notice: "Sign up successful. Please log in." }
        format.json { render :show, status: :created, location: @user }
      else
         # Displays error messages if user creation fails.
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/:id
  # Updates an existing user's details with the provided form data.
  # If successful, redirects back to the user profile page.
  # Otherwise, re-renders the edit form with validation feedback.
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/:id
  # Permanently removes a user record from the database.
  # After deletion, redirects to the users list with a confirmation message.
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # set_user method retrieves a specific user record based on the provided ID.
    # This method is reused by multiple actions to avoid redundant code.
    def set_user
      @user = User.find(params.expect(:id))
    end

    # Defines the list of permitted parameters for user creation and update.
    # This protects against mass-assignment vulnerabilities by allowing
    # only explicitly listed attributes to be modified.
    def user_params
      params.require(:user).permit(:fname, :lname, :email, :password, :is_admin, :status)
    end
end
