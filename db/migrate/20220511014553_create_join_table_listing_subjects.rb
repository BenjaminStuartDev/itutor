class CreateJoinTableListingSubjects < ActiveRecord::Migration[7.0]
  def change
    create_join_table :listings, :subjects do |t|
      # t.index [:listing_id, :subject_id]
      # t.index [:subject_id, :listing_id]
    end
  end
end
