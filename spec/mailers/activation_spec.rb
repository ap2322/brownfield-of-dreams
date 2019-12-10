require "rails_helper"

RSpec.describe ActivationMailer, type: :mailer do
  before(:each) do
    @user = create(:user, email: 'testing@testing.com')
  end

  describe 'sends activation email' do
    let(:mail) {ActivationMailer.activation(@user)}

    it 'renders the headers' do
      expect(mail.subject).to eq("Turing Tutorials Account Activation")
      expect(mail.to).to eq(["testing@testing.com"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it 'renders the body with an activation link' do
      expect(mail.body.encoded).to match("Visit here to activate your account.")
      expect(mail.body.encoded).to match("Activate Account")
    end

  end
end
