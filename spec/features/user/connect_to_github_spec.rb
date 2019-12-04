require 'rails_helper'

describe 'user can be authenticated via github' do
  it 'authenticates user and fetches user info from github' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'
    # OmniAuth.config.test_mode = true
    #
    # OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    #   :provider => 'github',
    #   :uid => '2345'
    #   })
    click_button 'Connect to Github'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
  end
end
