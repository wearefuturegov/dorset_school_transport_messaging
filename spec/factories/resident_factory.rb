FactoryBot.define do
  factory :resident do
    name { FFaker::Name.name }
    phone_number { "07#{rand(100..999)} #{rand(100000..999999)}" }
    route { FactoryBot.create(:route) }
  end
end
