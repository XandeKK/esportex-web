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
    it { should have_many_attached(:images_game) }

    it { should have_many(:game_participants).dependent(:destroy) }
    it { should have_many(:game_comments).dependent(:destroy) }

    it { should belong_to(:user) }
    it { should belong_to(:sport) }
  end

  describe "Active Storage" do
    it { should validate_content_type_of(:images_game).allowing('image/png', 'image/gif', 'image/jpeg') }
    it { should validate_content_type_of(:images_game).rejecting('text/plain', 'text/xml') }
    it { should validate_size_of(:images_game).less_than(25.megabytes) }
    it { should_not validate_size_of(:images_game).less_than(50.megabytes) }
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

    it "returns :invalid_timezone with invalid argument" do
      game = create(:game)
      expect(game.status("")).to eq(:invalid_timezone)
    end

    it "returns happened with string argument" do
      game = create(:game)
      expect(game.status("UTC")).to eq(:happened)
    end
  end

  describe "#join_game" do
    it "returns :successfully_joined" do
      game = create(:game)
      user = create(:user)

      result = game.join_game(user)

      expect(result).to eq(:successfully_joined)
    end

    it "returns :participating" do
      game = create(:game)

      result = game.join_game(game.user)

      expect(result).to eq(:participating)
    end

    it "raises ArgumentError without user" do
      game = create(:game)

      expect { game.join_game }.to raise_error(ArgumentError)
    end

    it "raises ActiveRecord::AssociationTypeMismatch with invalid argument" do
      game = create(:game)

      expect { game.join_game("sou eu trouxa") }.to raise_error(ActiveRecord::AssociationTypeMismatch)
    end

    # it "returns :full if game is full" do
    #   game = create(:game)
    #   game.maximum = 1
    #   user = create(:user)

    #   result = game.join_game(user)

    #   expect(result).to eq :full
    # end
  end
end
