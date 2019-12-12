require 'rails_helper'


describe 'an admin can update tutorial' do
  it 'user cannot update' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)

    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial1.id)
    video3 = create(:video, tutorial_id: tutorial2.id)
    video4 = create(:video, tutorial_id: tutorial2.id)

    expect{ put "/admin/api/v1/tutorial_sequencer/#{tutorial1.id}" }.to raise_error(ActionController::RoutingError)

  end
end
