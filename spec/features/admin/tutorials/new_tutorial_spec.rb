require 'rails_helper'

describe "An Admin can add a new tutorial" do
  let(:admin)    { create(:admin) }

  scenario "by visiting admin/tutorials/new", :js, :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path
    fill_in "tutorial[title]", with: "How to tie your shoes."
    fill_in "tutorial[description]", with: "Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through."
    fill_in "tutorial[thumbnail]", with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"
    click_on "Save"

    tutorial = Tutorial.last

    expect(current_path).to eq("/tutorials/#{tutorial.id}")
    expect(page).to have_content('Successfully created tutorial')
    expect(page).to have_content('How to tie your shoes.')
    expect(tutorial.description).to eq("Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through.")
    expect(tutorial.thumbnail).to eq("https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg")
  end
  scenario "cannot add without all fields filled", :js, :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path
    fill_in "tutorial[title]", with: ""
    fill_in "tutorial[description]", with: "Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through."
    fill_in "tutorial[thumbnail]", with: ""
    click_on "Save"

    expect(page).to have_content("Title can't be blank and Thumbnail can't be blank")
    expect(page).to have_content("New Tutorial")
  end

  scenario 'Ad admin can add a new tutorial with a video' do
    WebMock.enable_net_connect!
    VCR.eject_cassette
    VCR.turn_off!(ignore_cassettes: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in "tutorial[title]", with: "How to tie your shoes."
    fill_in "tutorial[description]", with: "Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through."
    fill_in "tutorial[thumbnail]", with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

    fill_in "tutorial[videos_attributes][0][title]", with: 'What'
    fill_in "tutorial[videos_attributes][0][description]", with: 'fun'
    fill_in "tutorial[videos_attributes][0][thumbnail]", with: 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg'
    fill_in 'tutorial[videos_attributes][0][video_id]', with: 'https://www.youtube.com/watch?v=acQS2Fef8tU'
    click_on "Save"

    tutorial = Tutorial.last
    expect(current_path).to eq("/tutorials/#{tutorial.id}")
    expect(page).to have_content('Successfully created tutorial')
  end
end
