module Custom
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end

  module FeatureHelpers
    def login(user)
      visit '/#/login'
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button 'Sign in'
    end
  end
end