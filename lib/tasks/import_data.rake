namespace :import do
  desc "Import movies and reviews from CSV"
  task :data => :environment do
    require 'csv'

    # Initialize variables to track successful imports and errors
    successful_imports = { movies: 0, reviews: 0 }
    errors = []

    # Use a transaction to ensure data integrity
    ActiveRecord::Base.transaction do
      begin
        # Import movies from movies.csv
        CSV.foreach('movies.csv', headers: true) do |row|
          movie = Movie.find_or_create_by(title: row['title'], release_year: row['release_year'])

          movie.update(description: row['description'], director: row['director'])

          actor = Actor.find_or_create_by(name: row['actor'])
          movie.actors << actor

          filming_location = FilmingLocation.find_or_create_by(name: row['filming_location'])
          movie.filming_locations << filming_location

          country = Country.find_or_create_by(name: row['country'])
          movie.countries << country

          successful_imports[:movies] += 1
        end

        # Import reviews from reviews.csv
        CSV.foreach('reviews.csv', headers: true) do |row|
          movie = Movie.find_by(title: row['movie_title'])
          user = User.find_or_create_by(name: row['user_name'])
          
          review = Review.new(movie: movie, user: user, stars: row['stars'], comment: row['comment'])
          if review.valid?
            review.save!
            successful_imports[:reviews] += 1
          else
            errors << "Invalid review data: #{review.errors.full_messages}"
          end
        end
      rescue StandardError => e
        errors << e.message
        raise ActiveRecord::Rollback # Rollback transaction if any error occurs
      end
    end

    # Print import summary
    puts "Import Summary:"
    puts "#{successful_imports[:movies]} movies imported successfully."
    puts "#{successful_imports[:reviews]} reviews imported successfully."
    errors.each { |error| puts "Error: #{error}" }
  end
end
