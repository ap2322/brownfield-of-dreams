require 'rails_helper'

describe 'YouTube service successfully makes api call' do
  it 'can make a json of video', :vcr do
    service = YoutubeService.new
    video = service.video_info(1)

    expect(video).to be_a(Hash)
    expect(video).to have_key :kind
    expect(video).to have_key :etag
    expect(video).to have_key :pageInfo
  end

  it 'can fetch json of a playslists videos', :vcr do

    playlist_id = 'PL1Y67f0xPzdOty2NDYKTRtxeoxvW1mAXu'
    service = YoutubeService.new
    playlist = service.playlist_videos_info(playlist_id)

    expect(playlist).to be_a(Hash)
    expect(playlist[:items]).to be_a(Array)
    expect(playlist[:items][0]).to be_a(Hash)
    expect(playlist[:items][0][:snippet]).to have_key :title
    expect(playlist[:items][0][:snippet]).to have_key :description
    expect(playlist[:items][0][:snippet]).to have_key :thumbnails
    expect(playlist[:items][0][:snippet][:resourceId]).to have_key :videoId
    expect(playlist[:items][0][:snippet]).to have_key :position
  end

  it 'can fetch json of a playslist tutorial info', :vcr do

    playlist_id = 'PL1Y67f0xPzdOty2NDYKTRtxeoxvW1mAXu'
    service = YoutubeService.new
    playlist = service.playlist_tutorial_info(playlist_id)

    expect(playlist[:items]).to be_a(Array)
    expect(playlist[:items][0][:snippet]).to have_key :title
    expect(playlist[:items][0][:snippet]).to have_key :description
    expect(playlist[:items][0][:snippet]).to have_key :thumbnails

  end
end
