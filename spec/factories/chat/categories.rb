FactoryBot.define do
  factory :chat_category, class: 'Chat::Category' do
    name { "Privado" }
    description { "Conversa entre duas pessoas" }
  end
end
