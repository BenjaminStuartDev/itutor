class Booking < ApplicationRecord
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  belongs_to :listing

  has_one :tutor, through: :listing
end
