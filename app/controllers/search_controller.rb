# SearchController handles the search functionality of the application.
# It allows users to search for public quotes based on their associated category names.
class SearchController < ApplicationController
  # GET /search
  # The main action for handling search requests.
  # Retrieves the search query from the parameters and performs a database search
  # for public quotes whose associated category names match the query.
  def index
     # Retrieve the text entered by the user from the search form.
    search_query = params[:query]
    # Check if the user has entered a search term if yes then execute the search query
    if search_query.present?
      @quotes = Quote.joins(:categories)
                     .where("categories.category_name LIKE ? AND quotes.is_public = ?", "%#{search_query}%", true)
                     .distinct
    else
      @quotes = Quote.none
    end
  end
end
