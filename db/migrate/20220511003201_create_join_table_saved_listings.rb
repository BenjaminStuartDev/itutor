class CreateJoinTableSavedListings < ActiveRecord::Migration[7.0]
  def change
    create_join_table :listings, :users do |t|
      # t.index [:listing_id, :user_id]
      t.index [:user_id, :listing_id]
    end
  end
end
