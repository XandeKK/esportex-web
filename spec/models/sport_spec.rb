require 'rails_helper'

describe Sport, type: :model do
  subject {
    Sport.new(
      name: "Volei",
      description: "See haikyuu!"
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is valid without description" do
    expect(subject).to be_valid
  end

  it "is not valid with description greater than 500" do
    subject.name = "Nada mesmo faz sentido" * 23
    expect(subject).to_not be_valid
  end

  context "of all bad name" do
    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with a name greater than 26" do
      subject.name = "Super onze" * 3
      expect(subject).to_not be_valid
    end
  end

  it "is not valid with existing name" do
    subject.save

    sport = Sport.new name: "Volei"

    expect(sport).to_not be_valid
  end
end
