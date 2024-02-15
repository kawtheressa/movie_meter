require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe "GET #index" do
    it "assigns @movies sorted by average stars when sort_by is 'average_stars'" do
      movie1 = create(:movie)
      movie2 = create(:movie)
      review1 = create(:review, movie: movie1, stars: 4)
      review2 = create(:review, movie: movie2, stars: 5)

      get :index, params: { sort_by: 'average_stars' }
      expect(assigns(:movies)).to eq([movie2, movie1])
    end

    it "assigns @movies sorted by created_at when sort_by is not provided" do
      movie1 = create(:movie)
      movie2 = create(:movie)

      get :index
      expect(assigns(:movies)).to eq([movie2, movie1])
    end
  end

  describe "GET #search" do
    it "assigns @movies filtered by actor name" do
      actor = create(:actor, name: "Tom Hanks")
      movie1 = create(:movie)
      movie2 = create(:movie)
      movie3 = create(:movie)
      movie1.actors << actor
      movie3.actors << actor

      get :search, params: { actor_name: "Tom Hanks" }
      expect(assigns(:movies)).to eq([movie3, movie1])
    end

    it "assigns all movies when actor_name is not provided" do
      movie1 = create(:movie)
      movie2 = create(:movie)

      get :search
      expect(assigns(:movies)).to eq([movie2, movie1])
    end
  end
end
