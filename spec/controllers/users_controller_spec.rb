require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "retuns a success response" do
      user = User.create name: "Adam", email: "adam@example.com", password: "asdfasdf"
      get :index, params: {}, session: {user_id: user.id}
      expect(response).to be_success
    end

    it "redirects to home page for visitors" do
      get :index, params: {}, session: {}
      expect(response).to redirect_to(root_path)
    end

    it "loads a list of users for logged in users" do 
      user = User.create! name: "Adam", email: "adam@example.com", password: "asdfasdf"
      get :index, params: {}, session: {user_id: user.id}
      expect(assigns(:users)).to eq [user]
    end
  end
end
