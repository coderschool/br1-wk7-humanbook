require 'rails_helper'

RSpec.describe WallController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      user = User.create name: "Adam", email: "adam@example.com", password: "asdfasdf"
      get :show, params: {id: user.id}
      expect(response).to have_http_status(:success)
    end
  end

end
