require 'rails_helper'

RSpec.describe Chat::Participant, type: :model do
  subject { build(:chat_participant) }

  it { should belong_to(:chat_room) }
  it { should belong_to(:user) }

  it do
    should validate_inclusion_of(:role).in_array(%w(Admin Normal Reader))
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
