require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:adam) { 
    User.create! name: "Adam", email: "adam@example.com", password: "asdfasdf"
  }
  let(:valid_session) {
    {user_id: adam.id}
  }

  describe "GET #index" do
    it "returns a success response" do
      user = User.create name: "Adam", email: "adam@example.com", password: "asdfasdf"
      get :index, params: {}, session: {user_id: user.id}
      expect(response).to be_success
    end

    it "redirects to home page for visitors" do
      get :index, params: {}, session: {}
      expect(response).to redirect_to(root_path)
      # test flash[:error] message to be "Access Denied"
    end

    it "loads a list of users for logged in users" do 
      adam
      bob = User.create! name: "Bob", email: "bob@example.com", password: "asdfasdf"
      expect(User.count).to eq 2
      get :index, params: {}, session: valid_session
      # we display newest users first
      expect(assigns(:users)).to eq [bob, adam]
    end
  end

  describe "GET #edit" do
    context "logged in user" do
      it "returns a success response" do
        adam
        get :edit, params: {}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "POST #create" do

    it "creates user" do
      post :create, params: {user: {name: "Quy", email: "q@monster.inc", password: "scary"}}
    end
  end
end
