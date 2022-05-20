class Review < ApplicationRecord
  # !!!! If not in use REMOVE the has one relationships !!!!!
  belongs_to :tutor, class_name: 'User'
  belongs_to :student, class_name: 'User'

  validates :tutor, :student, :content, presence: true
  validates :rating, numericality: true, presence: true
  validate :review_not_already_made, on: :post_create_action
  validate :review_made_with_valid_booking

  # returns and adds an error if the review has already been made.
  def review_not_already_made
    return if !rating || !content

    errors.add(:review, 'has already been made') if tutor.reviews.where(student: student).count == 1
  end
  # returns and adds an error if the review is being made with no valid booking.
  def review_made_with_valid_booking
    return if !rating || !content

    errors.add(:review, 'has no valid booking') unless student.booking_with?(tutor)
  end
end
