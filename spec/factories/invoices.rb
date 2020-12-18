FactoryBot.define do
  factory :invoice do 
    customer
    status { Faker::randomElement(['packaged', 'returned', 'shipped']) }
    merchant
  end
end