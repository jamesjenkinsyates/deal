FactoryGirl.define do

  sequence :email do |n|
    "ceo#{n}@nike.com" 
  end

  factory :business do
    company_name 'Nike'
    email
    password '12345678'
    password_confirmation '12345678'
    type 'Business'
    offers []
    category
  end
  
  factory :with_conversions, parent: :business do
    offers { Array.new(2) { FactoryGirl.create(:offer) } }
  end
  
end
