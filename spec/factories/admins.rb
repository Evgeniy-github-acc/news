FactoryBot.define do
  factory :admin do
    email { '123@mail.com' }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
