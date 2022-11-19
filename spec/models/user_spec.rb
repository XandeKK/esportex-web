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
  end

  it "is valid with valid attributes" do
    expect(build(:user)).to be_valid
  end
end
