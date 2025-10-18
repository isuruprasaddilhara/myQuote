# Model for storing and managing quotes in the MyQuote application
class Quote < ApplicationRecord
  # Each quote belongs to a specific user (who created it)
  belongs_to :user
  # Each quote is linked to one philosopher (who said or inspired it)
  belongs_to :philosopher
   # A quote can have many quote_categories (join table entries)
  has_many :quote_categories, dependent: :destroy
   # A quote can have many categories through the quote_categories join table
  has_many :categories, through: :quote_categories

   # Allow quotes to accept nested attributes for the join table
  accepts_nested_attributes_for :quote_categories, reject_if: :all_blank, allow_destroy: true
  # Quote text must be present and between 5 and 500 characters long
  validates :quote_text, presence: true, length: { minimum: 5, maximum: 500 }
  # Every quote must be associated with a user
  validates :user_id, presence: true
  # Ensures is_public is either true or false (used for visibility control)
  validates :is_public, inclusion: { in: [true, false] }
  # Published year must be a valid integer, non-negative, and not greater than the current year
  validates :published_year,
            numericality: {
              only_integer: true,
              allow_nil: true,
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: Date.current.year
            }

  # Comment is optional but cannot exceed 500 characters
  validates :comment, length: { maximum: 500 }, allow_blank: true
end
