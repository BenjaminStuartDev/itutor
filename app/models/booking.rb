class Booking < ApplicationRecord
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  belongs_to :listing

  has_one :tutor, through: :listing

  validates :student, presence: { message: 'must be signed in' }
  validates :start, presence: true
  validates :finish, comparison: { greater_than: :start }
  validate :booking_cannot_be_at_same_time_as_another_booking,
           :start_cannot_be_in_the_past, :user_must_be_student

  # Returns boolean true if a Booking is in the future
  def self.in_future
    where('start > :start', start: Time.zone.now.to_datetime)
  end

  # returns and adds an error if the user is not a student
  def user_must_be_student
    return if !start || !finish || student.has_role?(:student)

    errors.add(:student, 'must have student role. To change roles see Account')
  end

  # returns and adds an error if the booking is at the same time as another booking
  def booking_cannot_be_at_same_time_as_another_booking
    return if !start || !finish

    tutor_bookings = listing.tutor.bookings_as_tutor
    bookings = tutor_bookings.where(start: (start..finish))
                             .or(tutor_bookings.where(finish: (start..finish)))
                             .or(tutor_bookings.where('start < :start AND finish > :finish', start: start,
                                                                                             finish: finish))

    return if (tutor_bookings.length == 1 && tutor_bookings.first != self) || bookings.empty?

    errors.add :base, :invalid,
               message: "There is already another booking at #{bookings.first.start} to #{bookings.first.finish}"
  end

  # returns and adds an error if the booking is in the past.
  def start_cannot_be_in_the_past
    errors.add(:start, "can't be in the past") if start.present? && start < Time.zone.now.to_datetime
  end
end
