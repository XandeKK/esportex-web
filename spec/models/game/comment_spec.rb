require 'rails_helper'

RSpec.describe Game::Comment, type: :model do
  subject { build(:game_comment) }

  it { should belong_to(:user) }
  it { should belong_to(:game) }

  it { should validate_presence_of(:message) }
  it { should validate_length_of(:message).is_at_most(500) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
