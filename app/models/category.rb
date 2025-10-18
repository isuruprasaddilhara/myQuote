# Represents a category that can be assigned to multiple quotes.
# Deleting a category will also remove its related quote-category links.
class Category < ApplicationRecord
    has_many :quote_categories, dependent: :destroy
    has_many :quotes, through: :quote_categories
end
