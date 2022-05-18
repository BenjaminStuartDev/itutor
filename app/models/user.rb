class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_and_belongs_to_many :saved_listings, class_name: 'Listing', join_table: 'listings_users'
  has_many :listings, foreign_key: :tutor_id, dependent: :destroy

  has_many :bookings_as_student, foreign_key: :student_id, class_name: 'Booking', dependent: :destroy
  has_many :bookings_as_tutor, through: :listings, source: :bookings

  has_many :made_reviews, foreign_key: :student_id, class_name: 'Review'
  has_many :reviews, foreign_key: :tutor_id, class_name: 'Review', dependent: :destroy

  has_one_attached :profile_picture

  before_destroy :remove_review_student_id, prepend: true

  validates :name, presence: true, length: { minimum: 3 }

  def booking_with?(tutor)
    tutor.bookings_as_tutor.where(student: self).exists?
  end

  def reviewed?(tutor)
    tutor.reviews.where(student: self).exists?
  end

  def remove_review_student_id
    made_reviews.update_all(student_id: nil)
  end
end
