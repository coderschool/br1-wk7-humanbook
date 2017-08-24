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

  describe "autocomplete search" do
    before do 
      @stanley = User.create name: "Stanley", email: "adam@example.com", password: "asdfasdf"
      @ian = User.create name: "Ian", email: "adam@example2.com", password: "asdfasdf"
      @luis = User.create name: "Luis", email: "luis@example2.com", password: "asdfasdf"
    end
    it "finds stanley when given sta" do
      results = User.autocomplete("sta")
      expect(results.count).to eq(1)
      expect(results.first).to eq(@stanley)
    end

    it "doesnt find stanley when given stanleyc" do
      results = User.autocomplete("stanleyc")
      expect(results).not_to include(@stanley)
    end

    it "doesnt find stanley when given ian" do
      results = User.autocomplete("ian")
      expect(results).not_to include(@stanley)
    end
  end
end
