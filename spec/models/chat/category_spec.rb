require 'rails_helper'

RSpec.describe Chat::Category, type: :model do
  subject { build(:chat_category) }

  it { should have_many(:chat_rooms).dependent(:destroy) }
  
  it { should validate_uniqueness_of(:name).case_insensitive }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }


  it { should validate_length_of(:name).is_at_most(32) }
  it { should validate_length_of(:description).is_at_most(300) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
