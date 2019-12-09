require 'rails_helper'

describe 'A user can send an invitation to join the app' do
  it 'invite link from dashboard sends email invite' do
    user_1 = create(:user)
    
