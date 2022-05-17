class Listing < ApplicationRecord
  belongs_to :tutor, class_name: 'User', foreign_key: 'tutor_id'
  has_and_belongs_to_many :saved_by_users, class_name: 'User', join_table: 'listings_users'
  has_and_belongs_to_many :subjects
  has_many :bookings, dependent: :destroy

  validates :tutor, :title, :content, :subjects, presence: true

  def already_saved?(user)
    user.saved_listings.include?(self)
  end
end
