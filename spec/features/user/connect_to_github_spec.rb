require 'rails_helper'

describe 'user can be authenticated via github' do
  it 'authenticates user and fetches user info from github' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'
    mock_auth = OmniAuth.config.add_mock(:github, {:uid => '12345', :credentials => {token: "importanttoken"}, :info => {nickname: 'github_name', email: 'email@mock.com'}})

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
  end

  it 'displays user repos', :vcr do
    user = create(:user, token: ENV['GITHUB_TEST_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'
    expect(page.find_all('.repos')[0]).to have_content('')
    expect(page.find_all('.repos')[1]).to have_content('')
    expect(page.find_all('.repos')[2]).to have_content('')
    expect(page.find_all('.repos')[3]).to have_content('')
    expect(page.find_all('.repos')[4]).to have_content('')

  end
end
