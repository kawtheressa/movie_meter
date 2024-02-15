class MoviesController < ApplicationController
  def index
    if params[:actor_search].present?
      @movies = Movie.joins(:actors).where("actors.name LIKE ?", "%#{params[:actor_search]}%").uniq
    else
      @movies = Movie.all
    end
  end

  def search
    @actor_name = params[:actor_name]
    @movies = Movie.joins(:actors).where("actors.name LIKE ?", "%#{@actor_name}%").distinct
    render :index
  end
end
