FactoryBot.define do
  sequence :name do |n|
    "Privado#{n}"
  end

  factory :chat_category, class: 'Chat::Category' do
    name
    description { "Conversa entre duas pessoas" }
  end
end
