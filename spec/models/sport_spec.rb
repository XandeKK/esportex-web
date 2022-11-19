require 'rails_helper'

describe Sport, type: :model do
  subject { build(:sport) }

  it { should have_many(:games).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should_not allow_value("").for(:name) }
  it { should_not validate_length_of(:name).is_at_most(27) }

  it { should allow_value("").for(:description) }
  it { should_not validate_length_of(:description).is_at_most(501) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
