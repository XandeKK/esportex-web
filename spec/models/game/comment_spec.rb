require 'rails_helper'

RSpec.describe Game::Comment, type: :model do
  it { belong_to(:user) }
  it { belong_to(:game) }

  it { should validate_presence_of(:message) }
  it { should validate_length_of(:message).is_at_most(500) }
end
