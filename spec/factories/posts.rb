FactoryGirl.define do
  factory :post do
    title "MyString"
    body "MyText"
    likes 0
    association :tag
    association :author
  end

end
