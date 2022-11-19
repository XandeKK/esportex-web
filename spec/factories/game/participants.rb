FactoryBot.define do
  factory :game_participant, class: 'Game::Participant' do
    user { create(:user) }
    game { create(:game) }
  end
end
