require 'rails_helper'

RSpec.describe Chat::Track, type: :model do
  subject { build(:chat_track) }

  it { should belong_to(:chat_room) }
  it { should belong_to(:chat_participant) }

  it { should allow_value(DateTime.now).for(:last_view) }

  it { expect(subject).to be_valid }
end
