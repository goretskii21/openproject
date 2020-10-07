require File.dirname(__FILE__) + '/../test_helper'
class UserTest < Test::Unit::TestCase
  fixtures :users
  def test_truth
    assert_kind_of User, users(:first)
  end
end
