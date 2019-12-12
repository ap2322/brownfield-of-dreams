require 'rails_helper'


describe 'a user can add friends that are in the db', :vcr do
  it 'cannot add friend in db who is not a follower or following' do
    user = create(:user, token: ENV['GITHUB_TEST_TOKEN'])
    not_a_followering = create(:user, github_name: 'turingschool')
    naf_github = GithubUser.new({'handle'=>'turingschool'})

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'

    page.driver.post(friendships_path(friend_id: not_a_followering.id))
    expect(Friendship.all).to eq([])
  end

  scenario 'user starts with no followers' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'
    expect(user.user_followers).to eq([])
  end

  scenario 'user with followers has an array of follower handles' do
    user2 = create(:user, token: ENV['GITHUB_TEST_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
    visit '/dashboard'

    expect(user2.user_followers).to_not eq([])
    expect(user2.user_followers).to eq(["ALDENCO", "Kerstimcgee", "Jonpatt92", "mcat56"])

  end

  scenario 'user with followings has an array of followings handle' do
    user2 = create(:user, token: ENV['GITHUB_TEST_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
    visit '/dashboard'

    expect(user2.user_followings).to_not eq([])
    expect(user2.user_followings).to eq(["Kerstimcgee", "hillstew", "mcat56"])
  end
end
