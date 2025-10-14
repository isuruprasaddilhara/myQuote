class QuoteCategory < ApplicationRecord
  belongs_to :quote
  belongs_to :category

  # Ensures a blank category selection isn't saved.
  validates :category_id, presence: true
end
