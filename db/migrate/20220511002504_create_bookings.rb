class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :tutor, null: false, index: true, foreign_key: { to_table: :users }
      t.references :student, null: false, index: true, foreign_key: { to_table: :users }
      t.references :listing, null: false, foreign_key: true
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
