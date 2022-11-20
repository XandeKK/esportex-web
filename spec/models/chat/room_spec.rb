require 'rails_helper'

RSpec.describe Chat::Room, type: :model do
  describe "Validations" do
    subject { build(:chat_room) }

    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_most(50) }
    it { should validate_length_of(:bio).is_at_most(500) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  end

  describe "Associations" do
    it { should belong_to(:chat_category) }

    it { should have_many(:chat_participants).dependent(:destroy) }
    it { should have_many(:chat_messages).dependent(:destroy) }
    it { should have_many(:chat_tracks).dependent(:destroy) }
  end

  describe "#join_room" do
    it "returns :successfully_joined" do
      room = create(:chat_room)
      user = create(:user)

      result = room.join_room user

      expect(result).to eq(:successfully_joined)
    end

    it "returns :participating" do
      room = create(:chat_room)
      user = create(:user)

      room.join_room(user)

      result = room.join_room(user)

      expect(result).to eq(:participating)
    end

    it "raises ArgumentError without user" do
      room = create(:chat_room)

      expect { room.join_room }.to raise_error(ArgumentError)
    end

    it "raises ActiveRecord::AssociationTypeMismatch with invalid argument" do
      room = create(:chat_room)

      expect { room.join_room("sala pica") }.to raise_error(ActiveRecord::AssociationTypeMismatch)
    end
  end
end
