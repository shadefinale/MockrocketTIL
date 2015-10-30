module SignupMethods
  def fill_out_signup_form(**args)
    fill_in "author[username]", with: args[:username] || "test_user"
    fill_in "author[password]", with: args[:password] || "abcd1234"
    fill_in "author[password_confirmation]", with: args[:password_confirmation] ||"abcd1234"
  end
end
