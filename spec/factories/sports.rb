FactoryBot.define do
	sequence :name do |n|
    "Sport_#{n}"
  end

	factory :sport do
		name
		description { "See haikyuu" }
	end
end