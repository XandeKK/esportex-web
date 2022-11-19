FactoryBot.define do
  factory :chat_track, class: 'Chat::Track' do
    chat_room { create(:chat_room) }
    chat_participant { create(:chat_participant) }
    last_view { DateTime.now }
  end
end
