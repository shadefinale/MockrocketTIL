module SigninMethods
  def fill_out_signin_form(**args)
    fill_in "username", with: args[:username] || "test_user"
    fill_in "password", with: args[:password] || "abcd1234"
  end

  def current_auth_token
    Capybara.current_session.driver.request.cookies.[]('auth_token')
  end
end
