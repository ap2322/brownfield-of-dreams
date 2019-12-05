require 'rails_helper'

describe 'a user can see tutorials marked as classroom content if they are logged in' do
  it 'displays classroom content tutorials info' do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes", classroom: true)
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect(page).to have_content('How to Tie Your Shoes')
    expect(page).to have_content('The Bunny Ears Technique')
  end

  it 'will not display classroom content tutorials if user not logged in' do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes", classroom: true)
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    visit tutorial_path(tutorial)

    expect(page).to have_content('Please login to view content')
  end

end
