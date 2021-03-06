class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :tutor, null: false, index: true, foreign_key: { to_table: :users }
      t.references :student, null: true, index: true, foreign_key: { to_table: :users }
      t.text :content
      t.integer :rating

      t.timestamps
    end
  end
end
