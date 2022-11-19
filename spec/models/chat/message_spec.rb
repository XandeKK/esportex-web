require 'rails_helper'

RSpec.describe Chat::Message, type: :model do
  subject { build(:chat_message) }

  it { should belong_to(:chat_room) }
  it { should belong_to(:chat_participant) }

  it { should validate_presence_of(:message) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
