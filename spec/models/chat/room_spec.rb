require 'rails_helper'

RSpec.describe Chat::Room, type: :model do
  it { should belong_to(:chat_category) }

  # it { should have_many(:chat_participants) }
  # it { should have_many(:chat_messages) }
  # it { should have_many(:chat_tracks) }

  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name).is_at_most(50) }
  it { should validate_length_of(:bio).is_at_most(500) }
end
