require 'rails_helper'

describe 'user can see bookmarked segments on dashboard' do
  it 'adds videos to their bookmarks info is displayed on dahsboard' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    tutorial_1 = create(:tutorial, title: "How to Tie Your Shoes")
    tutorial_2 = create(:tutorial, title: "Eating Ice Cream")
    video_1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial_1)
    video_2 = create(:video, title: "Loop Around", tutorial: tutorial_1)
    video_3 = create(:video, title: "Banana Split", tutorial: tutorial_2)
    video_4 = create(:video, title: "Fudge Explosion", tutorial: tutorial_2)

    uv1 = user.user_videos.create(video_id: video_1.id)
    uv2 = user.user_videos.create(video_id: video_2.id)
    uv3 = user.user_videos.create(video_id: video_3.id)
    uv4 = user.user_videos.create(video_id: video_4.id)

    visit '/dashboard'

    within '.bookmarks' do
      expect(page).to have_content("How to Tie Your Shoes")
      expect(page.find_all('.video-bookmarks')[0]).to have_content('The Bunny Ears Technique')
      expect(page.find_all('.video-bookmarks')[1]).to have_content('Loop Around')

      expect(page).to have_content("Eating Ice Cream")
      expect(page.find_all('.video-bookmarks')[2]).to have_content('Banana Split')
      expect(page.find_all('.video-bookmarks')[3]).to have_content('Fudge Explosion')
    end
  end
end
