class CreateFilmingLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :filming_locations do |t|
      t.string :name

      t.timestamps
    end

    create_table :filming_locations_movies, id: false do |t|
      t.belongs_to :filming_location
      t.belongs_to :movie
    end

    add_index :filming_locations_movies, [:filming_location_id, :movie_id], name: 'index_filming_locations_movies_on_location_and_movie'
  end
end
