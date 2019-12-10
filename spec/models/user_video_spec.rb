require 'rails_helper'

RSpec.describe UserVideo, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :video }
  end
  describe 'class methods' do
    it 'tutorial sort' do
      user = create(:user)
      tutorial_1 = create(:tutorial, title: "How to Tie Your Shoes")
      tutorial_2 = create(:tutorial, title: "Eating Ice Cream")
      video_1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial_1)
      video_2 = create(:video, title: "Loop Around", tutorial: tutorial_1)
      video_3 = create(:video, title: "Banana Split", tutorial: tutorial_2)
      video_4 = create(:video, title: "Fudge Explosion", tutorial: tutorial_2)

      uv2 = user.user_videos.create(video_id: video_2.id)
      uv1 = user.user_videos.create(video_id: video_1.id)
      uv4 = user.user_videos.create(video_id: video_4.id)
      uv3 = user.user_videos.create(video_id: video_3.id)

      sorted_user_videos = user.user_videos.tutorial_sort
      expect(sorted_user_videos[0]).to eq(uv1)
      expect(sorted_user_videos[0].tutorial_title).to eq("How to Tie Your Shoes")
      expect(sorted_user_videos[1]).to eq(uv2)
      expect(sorted_user_videos[1].tutorial_title).to eq("How to Tie Your Shoes")
      expect(sorted_user_videos[2]).to eq(uv3)
      expect(sorted_user_videos[2].tutorial_title).to eq("Eating Ice Cream")
      expect(sorted_user_videos[3]).to eq(uv4)
      expect(sorted_user_videos[3].tutorial_title).to eq("Eating Ice Cream")
    end
  end
end
