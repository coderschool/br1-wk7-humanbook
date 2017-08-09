require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "add_friend should work" do
    a = User.create! name: "a", email: "a@example.com", password: "asdf"
    b = User.create! name: "b", email: "b@example.com", password: "asdf"
    a.add_friend(b)
    assert_equal [b], a.friends
  end
end
