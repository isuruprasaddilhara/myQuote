# Model for storing and managing user accounts in the MyQuote app
class User < ApplicationRecord
    # Enables secure password authentication (uses bcrypt to hash passwords)
    has_secure_password

    # A user can have many quotes; deleting a user removes their quotes too
    has_many :quotes, dependent: :destroy

     # First name and Last Name must be present and not exceed 50 characters
    validates :fname, presence: true, length: { maximum: 50 }
    validates :lname, presence: true, length: { maximum: 50 }

    # Email must be present, unique, and correctly formatted
    validates :email,presence: true,uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

    # User must have a valid status (Active, Suspended, or Banned)
    validates :status, presence: true, inclusion: { in: %w[Active Suspended Banned] }

    # Ensures the admin flag is always true or false (used for role-based access)
    validates_inclusion_of :is_admin, in: [true, false]
end
 