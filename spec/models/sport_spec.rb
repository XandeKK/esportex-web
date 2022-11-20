require 'rails_helper'

describe Sport, type: :model do
  describe "Validations" do
    subject { build(:sport) }

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

  describe "Associations" do
    it { should have_one_attached(:image_sport) }
    it { should have_many(:games).dependent(:destroy) }
  end

  describe "Active Storage" do
    it { should validate_content_type_of(:image_sport).allowing('image/png', 'image/gif', 'image/jpeg') }
    it { should validate_content_type_of(:image_sport).rejecting('text/plain', 'text/xml') }
    it { should validate_size_of(:image_sport).less_than(3.megabytes) }
    it { should_not validate_size_of(:image_sport).less_than(50.megabytes) }
  end
end
