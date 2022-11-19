FactoryBot.define do
  factory :chat_participant, class: 'Chat::Participant' do
    user { create(:user) }
    chat_room { create(:chat_room) }
    role { "Admin" }
  end
end
