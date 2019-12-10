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


end
