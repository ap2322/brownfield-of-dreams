require 'rails_helper'


describe GithubUser do
  #validate attributes on things not in db?
  # describe 'validations' do
  #   it { should validate_presence_of :handle }
  #   it { should validate_presence_of :html_url }
  # end

  describe 'attributes' do
    it 'has attributes' do
      github_user = GithubUser.new({'login' => 'tre23', 'html_url' => 'github.com/tre23'})

      expect(github_user.handle).to eq('tre23')
      expect(github_user.html_url).to eq('github.com/tre23')
    end
  end

  describe 'instance methods' do
    it 'in db' do
      github_user = GithubUser.new({'login' => 'tre23', 'html_url' => 'github.com/tre23'})
      user = create(:user, username: 'tre23')

      expect(github_user.in_db).to eq(user)

      github_user2 = GithubUser.new({'login' => 'plw54', 'html_url' => 'github.com/plw54'})

      expect(github_user2.in_db).to eq(nil)
    end
    it 'not_friend?' do
      github_user = GithubUser.new({'login' => 'tre23', 'html_url' => 'github.com/tre23'})
      github_user2 = GithubUser.new({'login' => 'plw54', 'html_url' => 'github.com/plw54'})
      github_user3 = GithubUser.new({'login' => 'slq09', 'html_url' => 'github.com/slq09'})
      user = create(:user, username: 'tre23')
      user2 = create(:user, username: 'plw54')
      user3 = create(:user, username: 'slq09' )

      user.friendships.create(friend_id: user2.id)

      expect(github_user2.not_friend?(user.id)).to eq(false)
      expect(github_user3.not_friend?(user.id)).to eq(true)
    end
  end
end
