require 'rails_helper'

describe User, type: :model do
  describe "Validations" do
    subject {
      described_class.new(
        name: "fulano",
        username: "fulano",
        email: "fulano@email",
        password: "fulano",
        bio: "eu sou o fulano"
      )
    }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is valid without a bio" do
      subject.bio = nil
      expect(subject).to be_valid
    end

    context "of all bad name" do
      it "is not valid without a name" do
        subject.name = nil
        expect(subject).to_not be_valid
      end

      it "is not valid with a name greater than 80 characters" do
        subject.name = "sofri" * 17
        expect(subject).to_not be_valid
      end
    end


    context "of all good username" do
      it do
        subject.username = "alexadre_dosa"
        expect(subject).to be_valid
      end

      it do
        subject.username = "xandekk-2"
        expect(subject).to be_valid
      end

      it do
        subject.username = "comi_o_cu_de_quem_esta_lendo"
        expect(subject).to be_valid
      end
    end

    context "of all bad username" do
      it "is not valid without an username" do
        subject.username = nil
        expect(subject).to_not be_valid
      end

      it "is not valid with an username greater than 36 characters" do
        subject.username = "fulano" * 7
        expect(subject).to_not be_valid
      end

      it do
        subject.username = "||...||"
        expect(subject).to_not be_valid
      end

      it do
        subject.username = "opa-+2?"
        expect(subject).to_not be_valid
      end

      it do
        subject.username = "mas#k#koo"
        expect(subject).to_not be_valid
      end

      it do
        subject.username = "mas que porra"
        expect(subject).to_not be_valid
      end
    end
  end
end
