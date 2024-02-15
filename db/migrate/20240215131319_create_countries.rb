class CreateCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :countries do |t|
      t.string :name

      t.timestamps
    end

    create_table :countries_movies, id: false do |t|
      t.belongs_to :country
      t.belongs_to :movie
    end

    add_index :countries_movies, [:country_id, :movie_id], name: 'index_countries_movies_on_country_and_movie'
  end
end
