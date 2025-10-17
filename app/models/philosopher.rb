class Philosopher < ApplicationRecord
    has_many :quotes

    # First name and last name: optional, max 50 characters
    validates :fname, length: { maximum: 50 }, presence: true
    validates :lname, length: { maximum: 50 }, allow_blank: true

    # Birth year and death year: optional, must be integers in a reasonable range
    validates :birth_year, numericality: { only_integer: true, greater_than_or_equal_to: -10000, less_than_or_equal_to: Date.today.year }, allow_nil: true
    validates :death_year, numericality: { only_integer: true, greater_than_or_equal_to: -10000, less_than_or_equal_to: Date.today.year }, allow_nil: true

    # Custom validation: death_year cannot be before birth_year
    validate :death_after_birth

    # Short bio: optional, max length 1000 characters
    validates :short_bio, length: { maximum: 1000 }, allow_blank: true

    private

    def death_after_birth
        return if birth_year.blank? || death_year.blank?

        if death_year < birth_year
        errors.add(:death_year, "cannot be earlier than birth year")
        end
    end
end
