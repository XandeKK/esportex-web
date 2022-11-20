FactoryBot.define do
  factory :chat_room, class: 'Chat::Room' do
    name { "Time pica" }
    bio { "E aí pica, aqui são os picas" }
    chat_category { create(:chat_category) }
    token { SecureRandom.urlsafe_base64(24, false) }
  end
end
