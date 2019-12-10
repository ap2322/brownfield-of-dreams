require "rails_helper"

RSpec.describe InvitationMailer, type: :mailer do
  before(:each) do
    @user = create(:user, email: 'testing@testing.com', github_name: 'Turing')
    @friend = GithubUser.new({'name' => 'Alice', 'login' => 'ap232', 'html_url' => 'github.com/ap232', 'email' => 'ap232@brownfield.com'})
  end

  describe 'sends activation email' do
    let(:mail) {InvitationMailer.invite(@user, @friend)}

    it 'renders the headers' do
      expect(mail.subject).to eq("You're Invited!")
      expect(mail.to).to eq(['ap232@brownfield.com'])
      expect(mail.from).to eq(["from@example.com"])
    end

    it 'renders the body with an activation link' do
      expect(mail.body.encoded).to match("Hello Alice")
      expect(mail.body.encoded).to match("#{@user.github_name} has invited you to join Brownfield MA!")
      expect(mail.body.encoded).to match("You can create an account")
      expect(mail.body.encoded).to have_link("here")
    end

  end
end
