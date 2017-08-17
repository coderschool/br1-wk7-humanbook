require "rails_helper"

RSpec.describe PostMailer, type: :mailer do
  describe "new_post" do
    let(:mail) { PostMailer.new_post }

    it "renders the headers" do
      expect(mail.subject).to eq("New post")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
