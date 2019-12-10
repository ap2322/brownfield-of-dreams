require 'rails_helper'

describe 'user can resend acivation email', :vcr, :js do
  before(:each) do
    ActionMailer::Base.deliveries = []
  end
  it 'link from dashboard to resend email' do
    user = create(:user)
    current_email_count = ActionMailer::Base.deliveries.count
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)


    visit '/dashboard'
    click_on 'Resend activation email'

    new_email_count = ActionMailer::Base.deliveries.count
    expect(new_email_count).to eq(current_email_count + 1)
  end
end
