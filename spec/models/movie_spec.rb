require 'rails_helper'

RSpec.describe Movie, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:release_year) }
  it { should_has_and_belongs_to_many(:actor)}
end
