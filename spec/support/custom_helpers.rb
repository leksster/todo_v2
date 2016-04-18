module Custom
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end

  module FeatureHelpers

    def sign_in_cookie(user)
      auth_headers = user.create_new_auth_token
      create_cookie('auth_headers', auth_headers.to_json)
      visit root_path
    end

    def sign_in_driver(user)
      auth_headers = user.create_new_auth_token
      page.driver.set_cookie('auth_headers', auth_headers.to_json)
      visit root_path
    end

    def login(user)
      visit '/#/login'
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button 'Sign in'
    end
  end
end