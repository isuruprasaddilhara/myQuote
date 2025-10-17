# HomeController manages the main pages of the application where quotes are displayed.
# It provides both public views for all users and personalized views for logged-in users.
class HomeController < ApplicationController
  # GET /
  # The main landing page of the app.
  # Fetches up to 10 public quotes, sorted by creation date in descending order (newest first),
  # and includes their associated categories to prevent N+1 queries.
  # The @quotes variable is then available in the view for display.
  def index
    @quotes = Quote.includes(:categories).where(is_public: true).order(created_at: :desc).limit(10)
  end
 
  # GET /uindex
  # Prepares data for the user profile page.
  # Finds the currently logged-in user based on the ID stored in the session
  # and makes it available to the view via the @user variable.
  # This allows the view to display personalized information about the user.
  def uindex
    @user = User.find(session[:user_id])
  end

  # Fetch all quotes that belong to the logged-in user and include their categories
  def uquotes
    @quotes = Quote.includes(:categories).where(user_id: session[:user_id]) 
  end 
end
