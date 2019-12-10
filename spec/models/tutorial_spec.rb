require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :thumbnail }
  end
  describe 'relationships' do
    it { should have_many :videos }

    it 'deletes videos when a tutorial is deleted' do
      user = create(:user)
      tutorial = create(:tutorial)
      video_1 = create(:video, tutorial_id: tutorial.id)
      video_2 = create(:video, tutorial_id: tutorial.id)
      video_3 = create(:video, tutorial_id: tutorial.id)
      user_video_1 = user.user_videos.create(video_id: video_3.id)

      tutorial.destroy
      no_videos = tutorial.videos

      expect(no_videos).to eq([])
      expect{ Video.find(video_1.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect{ Video.find(video_2.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect{ Video.find(video_3.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect{ UserVideo.find(user_video_1.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'instance methods' do
    it 'video_count' do
      tutorial = create(:tutorial)
      videos = create_list(:video, 3, tutorial_id: tutorial.id)

      expect(tutorial.video_count).to eq(3)
    end
  end
end
