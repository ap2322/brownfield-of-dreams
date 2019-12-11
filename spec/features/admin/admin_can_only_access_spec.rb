require 'rails_helper'

describe 'Admin authorization check' do
  let(:admin)    { create(:admin) }
  let(:user)    { create(:user) }

  it 'raises error when a non-admin user tries to access admin paths' do
    tutorial = create(:tutorial)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect{ visit new_admin_tutorial_path }.to raise_error(ActionController::RoutingError)
    expect{ visit admin_dashboard_path }.to raise_error(ActionController::RoutingError)
    expect{ visit edit_admin_tutorial_path(tutorial) }.to raise_error(ActionController::RoutingError)

  end

  it 'does not raise an error when an admin tries to access admin paths' do
    tutorial = create(:tutorial)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path
    expect(current_path).to eq(new_admin_tutorial_path)

    visit admin_dashboard_path
    expect(current_path).to eq(admin_dashboard_path)

    visit edit_admin_tutorial_path(tutorial)
    expect(current_path).to eq(edit_admin_tutorial_path(tutorial))
  end
end
