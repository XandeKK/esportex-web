require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "Validations" do
    subject { build(:game) }

    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:address) }

    it { should allow_value("").for(:title) }
    it { should allow_value(DateTime.now).for(:start_date) }
    it { should allow_value(DateTime.now).for(:end_date) }

    it { should_not allow_value(20.days.ago).for(:end_date) }
    it { should_not allow_value(20.days.after).for(:start_date) }

    it { should_not allow_value("").for(:start_date) }
    it { should_not allow_value("dez da noite").for(:start_date) }
    it { should_not allow_value("").for(:end_date) }
    it { should_not allow_value("5 da tarde ou 5 da noite?").for(:end_date) }

    it { expect(subject.end_date).to be > subject.start_date }

    it { should validate_length_of(:title).is_at_most(100)}
    it { should validate_length_of(:info).is_at_most(500)}

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  end

  describe "Associations" do
    it { should have_many(:game_participants).dependent(:destroy) }
    it { should have_many(:game_comments).dependent(:destroy) }

    it { should belong_to(:user) }
    it { should belong_to(:sport) }
  end

  describe "#status" do
    it "returns will happen if current time is less than start date" do
      game = create(:game)
      game.start_date = 1.hours.after
      game.end_date = 2.hours.after

      expect(game.status(Time.zone)).to eq(:will_happen)
    end

    it "returns happening if current time is greater than start date and less than end date" do
      game = create(:game)
      game.start_date = 2.hours.ago
      game.end_date = 2.hours.after

      expect(game.status(Time.zone)).to eq(:happened)
    end

    it "returns over if current time is greater than end date" do
      game = create(:game)
      game.start_date = 3.hours.ago
      game.end_date = 1.hours.ago

      expect(game.status(Time.zone)).to eq(:over)
    end
  end
end
