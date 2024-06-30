# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    nickname { Faker::Name.unique.name }
    last_name { '山田' }
    first_name { '太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    birth_day { Faker::Date.birthday(min_age: 18, max_age: 65) }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password } # passwordと一致させる
  end
end
