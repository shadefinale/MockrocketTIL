FactoryGirl.define do
  factory :post do
    title "MyString"
    body "MyText"
    association :tag
  end

end
