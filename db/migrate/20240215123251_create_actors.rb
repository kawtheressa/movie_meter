class CreateActors < ActiveRecord::Migration[6.0]
  def change
    create_table :actors do |t|
      t.string :name

      t.timestamps
    end

    create_table :actors_movies, id: false do |t|
      t.belongs_to :actor
      t.belongs_to :movie
    end

    add_index :actors_movies, [:actor_id, :movie_id]
  end
end