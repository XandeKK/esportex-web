require 'rails_helper'

RSpec.describe Chat::Room, type: :model do
  subject { build(:chat_room) }

  it { should belong_to(:chat_category) }

  it { should have_many(:chat_participants).dependent(:destroy) }
  it { should have_many(:chat_messages).dependent(:destroy) }
  it { should have_many(:chat_tracks).dependent(:destroy) }

  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name).is_at_most(50) }
  it { should validate_length_of(:bio).is_at_most(500) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
