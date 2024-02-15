namespace :import do
  desc "Import movies and reviews from CSV"
  task :data => :environment do
    require 'csv'

    # Import movies from movies.csv if not already present in the database
    CSV.foreach('movies.csv', headers: true) do |row|
      # Find or create a movie by its title, description, director and release year
      movie = Movie.find_or_create_by(title: row['title'], 
        release_year: row['release_year'],
        description: row['description'], 
        director: row['director'])

      # Import actors
      actor = Actor.find_or_create_by(name: row['actor'])
      movie.actors << actor

      # Import filming_location 
      filming_location = FilmingLocation.find_or_create_by(name: row['filming_location'])
      movie.filming_locations << filming_location

      # Import countries 
      country = Country.find_or_create_by(name: row['country'])
      movie.countries << country

      puts "Movie Imported: #{movie.title} (#{movie.release_year})"
    end

    # Import reviews from reviews.csv using movie and user names
    CSV.foreach('reviews.csv', headers: true) do |row|
      # Find the movie by its title
      movie = Movie.find_by(title: row['movie_title'])

      # Find or create a user by their name
      user = User.find_or_create_by(name: row['user_name'])
      
      # Create a review with the found movie, user, stars, and comment
      review = Review.create!(movie: movie, user: user, stars: row['stars'], comment: row['comment'])
      puts "Imported review: #{review.stars} stars by #{user.name} for #{movie.title}"
    end
  end
end
