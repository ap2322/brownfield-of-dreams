require 'rails_helper'


describe 'a user can add friends that are in the db' do
  it 'there is a link from the user dashboard to add friend if in db', :vcr do
    user = create(:user, token: ENV['GITHUB_TEST_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    follower_in_db = create(:user,first_name: 'Alice', last_name: 'Post', username: 'ap2322')
    following_in_db = create(:user, first_name: 'Rachel', last_name: 'Lew', username: 'rlew421')

    visit '/dashboard'

    within "#follower-1" do #alice
      click_link 'Add Friend'
    end

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Friend added!')

    within ".friends" do
      expect(page).to have_content('Alice Post (ap2322)')
    end

    within "#follower-1" do
      expect(page).to_not have_link('Add Friend')
    end

    within "#following-7" do #rachel
      click_link 'Add Friend'
    end

    expect(page).to have_content('Friend added!')

    within ".friends" do
      expect(page).to have_content('Rachel Lew (rlew421)')
    end

    within "#follower-0" do #john
      expect(page).to_not have_link('Add Friend')
    end

    within ".friends" do
      expect(page).to_not have_content('johnktravers')
    end

    within "#following-5" do #john
      expect(page).to_not have_link('Add Friend')
    end

    within ".friends" do
      expect(page).to_not have_content('johnktravers')
    end
  end
end
