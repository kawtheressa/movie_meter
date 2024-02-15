class Movie < ApplicationRecord
  has_and_belongs_to_many :actors
  has_and_belongs_to_many :filming_locations
  has_and_belongs_to_many :countries
  has_many :reviews

  validates :title, presence: true
  validates :release_year, presence: true
end
