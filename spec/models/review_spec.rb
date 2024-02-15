require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to(:movie) }
  it { should belong_to(:user) }

end
