FactoryGirl.define do
  factory :author do
    sequence(:username) {|n| "Mr_#{n}"}
  end

end
