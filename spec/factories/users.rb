FactoryBot.define do
  sequence :username do |n|
    "fulano_#{n}"
  end

  sequence :email do |n|
    "fulano_#{n}@gmail.com"
  end

  factory :user do
    name { "Fanstama" }
    email 
    username 
    password { "password" }
    bio { "Eu preciso gritar" }
  end
end
