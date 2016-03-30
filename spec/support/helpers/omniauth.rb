module Omniauth

  module Mock
    def auth_mock
      OmniAuth.config.mock_auth[:facebook] = {
        'provider'  => 'facebook',
        'uid'       => '123545',
        'user_info' => {
          'name'    => 'mockuser'
        },
        'credentials' => {
          'token'   => 'mock_token',
          'secret'  => 'mock_secret'
        }
      }
    end
  end

  module SessionHelpers
    def signin
      visit root_path
      expect(page).to have_content("Sign in")
      auth_mock
      within('nav') do
        click_link "Sign in"
      end
    end
  end

end
