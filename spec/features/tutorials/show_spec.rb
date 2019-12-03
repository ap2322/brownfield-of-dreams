require 'rails_helper'

describe 'tutorial show page' do
  it 'loads without videos' do
    tutorial = create(:tutorial)

    visit "/tutorials/#{tutorial.id}"

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content(tutorial.title)
  end
end
