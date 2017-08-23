require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PostsHelper. For example:
#
# describe PostsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PostsHelper, type: :helper do
  describe "mentions text" do
    before(:each) do
      2.times do 
        User.generate_test_user_fast
      end
      Post.generate_posts(2, nil, false)
      @post_with_no = Post.first
      @post_with_one = Post.last
      @mentioned_user_quy_test = User.first
      @mentioned_user_quy_test.name = "Quy Test User"
      @mentioned_user_quy_test.save
      @post_with_one.mentions << Mention.create(user: @mentioned_user_quy_test)
      
      # Now generate a post that has 2 mentions
      Post.generate_posts(1, nil, false)
      @post_with_two = Post.last
      @post_with_two.mentions << Mention.create(user: @mentioned_user_quy_test)
      @post_with_two.mentions << Mention.create(user: User.random_user)

    end

    it "should return nothing if there are no mentions" do
      expect(mentions_text(@post_with_no)).to be_empty
    end

    it "should return with the user name if there is one user" do
      expect(mentions_text(@post_with_one)).to eq("with Quy Test User")
    end

    it "should say the first person, with _x_ other if there are 2 mentioned users" do
      output = mentions_text(@post_with_two)
      expect(output).to eq("with Quy Test User and 1 other")
    end
    it "should say the first person, with _x_ others if there is more than 2 mentioned users" do
      2.times do 
        @post_with_two.mentions << Mention.create(user: User.random_user)
      end        
      output = mentions_text(@post_with_two)
      expect(output).to eq("with Quy Test User and 3 others")
    end
  end
end
