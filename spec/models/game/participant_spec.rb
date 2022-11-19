require 'rails_helper'

describe Game::Participant, type: :model do
  it { belong_to(:game) }
  it { belong_to(:user) }
end
