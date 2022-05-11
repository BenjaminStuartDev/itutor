class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.references :tutor, null: false, index: true, foreign_key: { to_table: :users }
      t.string :title
      t.string :content
      t.timestamps
    end
  end
end
