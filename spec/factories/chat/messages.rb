FactoryBot.define do
  factory :chat_message, class: 'Chat::Message' do
    chat_room { create(:chat_room) }
    chat_participant { create(:chat_participant) }
    message { "Pra mim, é só um dia normal" }
  end
end
