require 'rails_helper'

describe 'GitHubService makes successful api calls' do
  it 'can make a json of video', :vcr do
    service = YoutubeService.new
    video = service.video_info(1)

    expect(video).to be_a(Hash)
    expect(video).to have_key :kind
    expect(video).to have_key :etag
    expect(video).to have_key :pageInfo
  end


end
