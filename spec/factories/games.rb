FactoryBot.define do
  factory :game do
    user { create(:user) }
    sport { create(:sport) }
    title { "Vamos jogar" }
    start_date { 5.hours.ago }
    end_date { 1.hours.after }
    address { "Lá na puta que pariu" }
    info { "Qualquer trouxa pode jogar" }
  end
end
