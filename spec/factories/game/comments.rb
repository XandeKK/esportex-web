FactoryBot.define do
  factory :game_comment, class: 'Game::Comment' do
    user { create(:user) }
    game { create(:game) }
    message { "Você aceitam aqueles que não sabem jogar?" }
  end
end
