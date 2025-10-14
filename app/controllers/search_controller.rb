# class SearchController < ApplicationController
#   def index
#     search_query = params[:query]
#     if search_query.present?
#       @quotes = Quote.where("is_public = ? AND quote_text LIKE ?", true, "%#{search_query}%")
#     end
#   end
# end

class SearchController < ApplicationController
  def index
    search_query = params[:query]
    if search_query.present?
      @quotes = Quote.joins(:categories)
                     .where("categories.category_name LIKE ? AND quotes.is_public = ?", "%#{search_query}%", true)
                     .distinct
    else
      @quotes = Quote.none
    end
  end
end
