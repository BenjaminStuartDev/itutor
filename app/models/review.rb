class Review < ApplicationRecord
  # !!!! If not in use REMOVE the has one relationships !!!!!
  belongs_to :tutor, class_name: 'User'
  belongs_to :student, class_name: 'User'
end
