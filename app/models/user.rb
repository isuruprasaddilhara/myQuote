class User < ApplicationRecord
    has_secure_password
    has_many :quotes, dependent: :destroy

    validates :fname, presence: true, length: { maximum: 50 }
    validates :lname, presence: true, length: { maximum: 50 }
    validates :email,presence: true,uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :status, presence: true, inclusion: { in: %w[Active Suspended Banned] }
    validates_inclusion_of :is_admin, in: [true, false]
end
 