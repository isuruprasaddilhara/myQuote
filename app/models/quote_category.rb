# The QuoteCategory model represents the many-to-many relationship 
# between quotes and categories in the database.
class QuoteCategory < ApplicationRecord
  belongs_to :quote
  belongs_to :category

  # Validation: Ensures that a category must be selected before saving.
  validates :category_id, presence: true
end
