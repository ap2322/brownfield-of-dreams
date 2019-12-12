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

  it 'can fetch json of a playslist', :vcr do
    playlist_id = 'PL1Y67f0xPzdOty2NDYKTRtxeoxvW1mAXu'
    service = YoutubeService.new
    playlist = service.playlist_info(playlist_id)

    expect(playlist).to be_a(Array)
    expect(playlist[0]).to have_key :kind
    expect(playlist[0]).to have_key :etag
    expect(playlist[0]).to have_key :id
    expect(playlist[0]).to have_key :snippet
  end
end
