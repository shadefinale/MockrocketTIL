FactoryGirl.define do
  factory :author do
    sequence(:username) {|n| "username_#{n}"}
    password "12345678"
    password_confirmation "12345678"
  end

end
