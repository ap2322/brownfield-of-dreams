require 'rails_helper'

describe 'vister can create an account', :vcr, :js do
  before(:each) do
    ActionMailer::Base.deliveries = []
  end

  it ' visits the home page' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content(email)
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to_not have_content('Sign In')
  end

  it 'visits home page to register and activate via email' do
    current_email_count = ActionMailer::Base.deliveries.count

    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'
    click_on 'Register'

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'

    user = User.last

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Logged in as Jim')
    expect(page).to have_content('This account has not yet been activated. Please check your email.')

    new_email_count = ActionMailer::Base.deliveries.count

    expect(new_email_count).to eq(current_email_count + 1)

    last_email = ActionMailer::Base.deliveries.last
    expect(last_email.to).to include(email)
    expect(last_email.body).to have_content("Visit here to activate your account.")
    expect(last_email.body).to have_link("Activate Account")

    visit "/users/#{user.id}/activation"

    expect(page).to have_content("Thank you! Your account is now activated.")

    visit '/dashboard'
    expect(page).to have_content('Status: Active')
    expect(page).to_not have_content('This account has not yet been activated. Please check your email.')
  end
end
