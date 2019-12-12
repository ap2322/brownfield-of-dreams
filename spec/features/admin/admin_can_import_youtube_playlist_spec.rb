# As an admin
# When I visit '/admin/tutorials/new'
# Then I should see a link for 'Import YouTube Playlist'
# When I click 'Import YouTube Playlist'
# Then I should see a form
#
# And when I fill in 'Playlist ID' with a valid ID
# Then I should be on '/admin/dashboard'
# And I should see a flash message that says 'Successfully created tutorial. View it here.'
# And 'View it here' should be a link to '/tutorials/:id'
# And when I click on 'View it here'
# Then I should be on '/tutorials/:id'
# And I should see all videos from the YouTube playlist
# And the order should be the same as it was on YouTube
require 'rails_helper'

describe 'Admin can import a youtube playlist from tutorials new page', :vcr do
 it 'has link to import youtube playlist' do
   admin = create(:admin)
   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

   visit '/admin/tutorials/new'

   click_link 'Import YouTube Playlist'

   expect(current_path).to eq("/admin/playlist_tutorials/new")
 end
 it 'has a form to select a Tutorial and Youtube playlist id that creates a tutorial with playlist' do
   WebMock.enable_net_connect!
   VCR.eject_cassette
   VCR.turn_off!(ignore_cassettes: true)
   admin = create(:admin)
   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

   visit "/admin/playlist_tutorials/new"

   fill_in 'Playlist', with: 'PL1Y67f0xPzdOty2NDYKTRtxeoxvW1mAXu'
   click_on 'Save'

   expect(current_path).to eq('/admin/dashboard')
   expect(page).to have_content('Successfully created tutorial. View it here.')

   click_link 'View it here.'

   expect(current_path).to be("/tutorials/#{tutorial_1.id}")
   expect(page).to have_content("All the videos from the playlist")
 end
end
