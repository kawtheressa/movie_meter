class MoviesController < ApplicationController
  def index
    @movies = Movie.joins(:reviews)
    
    case params[:sort_by]
    when 'average_stars'
      @movies = @movies.group(:id)
                       .order("AVG(reviews.stars) DESC NULLS LAST")
    else
      @movies = @movies.order(created_at: :desc).uniq
    end
  end

  def search
    @actor_name = params[:actor_name]
    @movies = Movie.joins(:actors).where("actors.name LIKE ?", "%#{@actor_name}%").distinct
    render :index
  end
end
