require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:adam) { User.create name: "Adam", email: "adam@example.com", password: "asdfasdf"}
  let(:bob) { User.create name: "Bob", email: "bob@example.com", password: "asdfasdf"}
  let(:valid_session) { {user_id: adam.id} }

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    it "creates a new Message" do
      expect {
        post :create, params: {message: {recipient_id: bob.id, body: "test"}}, session: valid_session
      }.to change(Message, :count).by(1)
    end
  end
end
