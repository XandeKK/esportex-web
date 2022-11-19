require 'rails_helper'

describe Game::Participant, type: :model do
  subject { build(:game_participant) }

  it { should belong_to(:game) }
  it { should belong_to(:user) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
