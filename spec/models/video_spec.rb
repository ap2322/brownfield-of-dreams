require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:video_id)}
    it {should validate_presence_of(:thumbnail)}
  end

  describe 'relationships' do
    it { should belong_to :tutorial }
  end

  describe 'callbacks' do
    it 'increments the position before creation' do
      tutorial = create(:tutorial)
      video_1 = create(:video, tutorial_id: tutorial.id)
      video_2 = create(:video, tutorial_id: tutorial.id)
      video_3 = create(:video, tutorial_id: tutorial.id)

      expect(video_1.position).to eq(1)
      expect(video_2.position).to eq(2)
      expect(video_3.position).to eq(3)
    end
  end

end
