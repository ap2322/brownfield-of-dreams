require 'rails_helper'

describe 'user can be authenticated and grant acces via github' do
  it 'authenticates user and fetches user info from github', :vcr do
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

  it 'displays five of the users repos', :vcr do
    user = create(:user, token: ENV['GITHUB_TEST_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'
    within '.repos' do
      expect(page).to have_css('#repo-0')
      expect(page).to have_css('#repo-1')
      expect(page).to have_css('#repo-2')
      expect(page).to have_css('#repo-3')
      expect(page).to have_css('#repo-4')
    end

    expect(page.find('#repo-0')).to_not be_nil

  end
end
