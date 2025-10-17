class Quote < ApplicationRecord
  belongs_to :user
  belongs_to :philosopher
  has_many :quote_categories, dependent: :destroy
  has_many :categories, through: :quote_categories

   # Allow quotes to accept nested attributes for the join table
  accepts_nested_attributes_for :quote_categories, reject_if: :all_blank, allow_destroy: true

  validates :quote_text, presence: true, length: { minimum: 5, maximum: 500 }
  validates :user_id, presence: true
  validates :is_public, inclusion: { in: [true, false] }
  validates :published_year,
            numericality: {
              only_integer: true,
              allow_nil: true,
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: Date.current.year
            }
  validates :comment, length: { maximum: 250 }, allow_blank: true
end
