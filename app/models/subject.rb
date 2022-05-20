class Subject < ApplicationRecord
  has_and_belongs_to_many :listings

  def self.possible_subjects
    %w[English Maths Science]
  end
end
