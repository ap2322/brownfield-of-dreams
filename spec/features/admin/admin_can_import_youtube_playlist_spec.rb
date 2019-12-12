require 'rails_helper'

describe 'Admin can import a youtube playlist from tutorials new page' do
 it 'has link to import youtube playlist' do
   admin = create(:admin)
   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

   visit '/admin/tutorials/new'

   click_link 'Import YouTube Playlist'

   expect(current_path).to eq("/admin/playlist_tutorials/new")
 end
 it 'has a form to select a Tutorial and Youtube playlist id that creates a tutorial with playlist', :vcr do
   admin = create(:admin)
   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

   tutorial_count = Tutorial.all.count

   visit "/admin/playlist_tutorials/new"

   fill_in 'Playlist', with: 'PL1Y67f0xPzdOty2NDYKTRtxeoxvW1mAXu'
   click_on 'Save'

   tutorial = Tutorial.last
   expect((tutorial_count + 1)).to eq(Tutorial.all.count)

   expect(current_path).to eq('/admin/dashboard')
   expect(page).to have_content('Successfully created tutorial. View it here.')

   click_link 'View it here'

   expect(current_path).to eq("/tutorials/#{tutorial.id}")

   expect(page).to have_content(tutorial.title)

  tutorial.videos.each do |video|
    expect(page).to have_content(video.title)
  end
 end
end
