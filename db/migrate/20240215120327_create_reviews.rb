class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :movie, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :stars
      t.text :comment

      t.timestamps
    end
  end
end
