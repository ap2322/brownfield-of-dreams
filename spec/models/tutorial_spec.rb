require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :thumbnail }
  end
  describe 'relationships' do
    it { should have_many :videos }
  end
  describe 'instance methods' do
    it 'video_count' do
      tutorial = create(:tutorial)
      videos = create_list(:video, 3, tutorial_id: tutorial.id)

      expect(tutorial.video_count).to eq(3)
    end
  end
end
