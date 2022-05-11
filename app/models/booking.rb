class Booking < ApplicationRecord
  belongs_to :tutor, class_name: 'User', foreign_key: 'tutor_id'
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  belongs_to :listing
  has_one :review, required: false, dependent: :destroy
end
