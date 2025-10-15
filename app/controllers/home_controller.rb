class HomeController < ApplicationController
  def index
    @quotes = Quote.includes(:categories).where(is_public: true).limit(10)
  end
  def uquotes
    @quotes = Quote.includes(:categories).where(user_id: session[:user_id]) 
  end
  def uindex
    # Find the current user and make it available to the view
    # This assumes you store the user's ID in session[:user_id] upon login
    @user = User.find(session[:user_id])
  end
end
