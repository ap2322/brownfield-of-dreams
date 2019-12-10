require 'rails_helper'


describe 'user can invite friends' do
  before(:each) do
    ActionMailer::Base.deliveries = []
  end

  it 'invite link from dashboard sends email invite' do
    WebMock.enable_net_connect!
    VCR.eject_cassette
    VCR.turn_off!(ignore_cassettes: true)
    user_1 = create(:user, token: ENV['GITHUB_TEST_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/dashboard'

    click_link 'Send Invite'

    expect(current_path).to eq('/invite')

    fill_in 'Github handle', with: 'turingschool'
    click_on 'Send Invite'

    last_email = ActionMailer::Base.deliveries.last
    expect(last_email.to).to include('contact@turing.io')

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Successfully sent invite!')
  end
  it 'invite link from dashboard will not send email if github user does not have email' do
    WebMock.enable_net_connect!
    VCR.eject_cassette
    VCR.turn_off!(ignore_cassettes: true)
    user_1 = create(:user, token: ENV['GITHUB_TEST_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/dashboard'

    click_link 'Send Invite'

    expect(current_path).to eq('/invite')

    fill_in 'Github handle', with: 'johnktravers'
    click_on 'Send Invite'

    expect(ActionMailer::Base.deliveries).to eq([])

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
