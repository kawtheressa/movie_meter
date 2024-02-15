class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :release_year
      t.string :director
      t.string :actor
      t.string :filming
      t.string :location
      t.string :country

      t.timestamps
    end
  end
end