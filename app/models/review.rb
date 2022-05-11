class Review < ApplicationRecord
  belongs_to :booking
  # !!!! If not in use REMOVE the has one relationships !!!!!
  has_one :tutor, through: :booking
  has_one :student, through: :booking
  has_one :listing, through: :booking
end
