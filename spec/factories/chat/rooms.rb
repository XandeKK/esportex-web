FactoryBot.define do
  factory :chat_room, class: 'Chat::Room' do
    name { "Time pica" }
    bio { "E aí pica, aqui são os picas" }
    chat_category { create(:chat_category) }
  end
end
