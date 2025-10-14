class SearchController < ApplicationController
  def index
    search_query = params[:query]
    if search_query.present?
      @quotes = Quote.where("is_public = ? AND quote_text LIKE ?", true, "%#{search_query}%")
    end
  end
end