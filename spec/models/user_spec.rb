require 'rails_helper'

describe User, type: :model do
  describe "Validations" do
    subject { build(:user) }

    it { should validate_presence_of(:name) }

    it { should_not allow_value("").for(:name) }
    it { should_not validate_length_of(:name).is_at_most(81) }

    it { should validate_presence_of(:username) }

    it { should allow_value("alexadre_dosa").for(:username) }
    it { should allow_value("xande--kk").for(:username) }
    it { should allow_value("123").for(:username) }

    it { should_not allow_value("").for(:username) }
    it { should_not allow_value("|velho_arrombado|").for(:username) }
    it { should_not allow_value("123+456").for(:username) }
    it { should_not allow_value("koo#").for(:username) }
    it { should_not allow_value("nao funciona").for(:username) }
    it { should_not validate_length_of(:username).is_at_most(37) }

    it { should validate_uniqueness_of(:username).case_insensitive }

    it { should allow_value("").for(:bio) }
    it { should_not validate_length_of(:bio).is_at_most(501) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  end

  describe "Associations" do
    it { should have_one_attached(:avatar) }

    it { should have_many(:games).dependent(:destroy) }
    it { should have_many(:game_participants).dependent(:destroy) }
    it { should have_many(:game_comments).dependent(:destroy) }
  end

  describe "Active Storage" do
    it { should validate_content_type_of(:avatar).allowing('image/png', 'image/gif', 'image/jpeg') }
    it { should validate_content_type_of(:avatar).rejecting('text/plain', 'text/xml') }
    it { should validate_size_of(:avatar).less_than(25.megabytes) }
    it { should_not validate_size_of(:avatar).less_than(50.megabytes) }
  end
end
