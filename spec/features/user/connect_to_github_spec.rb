require 'rails_helper'

describe 'user can be authenticated and grant acces via github' do
  it 'authenticates user and fetches user info from github' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    stub_omniauth
    visit '/dashboard'
    expect(page).to_not have_css('.github_info')
    click_button 'Connect to GitHub'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_css('.github_info')

    within('.github_info') do
      expect(page).to have_content(user.username)
    end
  end
end
