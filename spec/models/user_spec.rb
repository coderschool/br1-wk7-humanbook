require 'rails_helper'

RSpec.describe User, type: :model do
  describe "valid user" do
    before do
      @user = User.create name: "Adam", email: "adam@example.com", password: "asdfasdf"
    end

    it "creates successfully" do
      # expect(@user.valid?).to eq true
      expect(@user).to be_valid
    end

    it "has a valid image_url_or_default" do
      expect(@user.image_url_or_default).to eq "http://lorempixel.com/128/128/sports/Fake-User/"
    end
  end
end
