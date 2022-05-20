class Subject < ApplicationRecord
  has_and_belongs_to_many :listings
  # returns an array of strings for all possible subjects
  def self.possible_subjects
    %w[English Maths Science]
  end
end
