require 'rails_helper'

describe 'Repository' do
  describe 'attributes' do
    it 'has attributes' do
      repo = Repository.new({'name' => 'Brownfield', 'html_url' => 'github.com/brownfield'})

      expect(repo.name).to eq('Brownfield')
      expect(repo.html_url).to eq('github.com/brownfield')
    end
  end
end
