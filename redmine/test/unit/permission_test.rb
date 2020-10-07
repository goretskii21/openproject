require File.dirname(__FILE__) + '/../test_helper'
class PermissionTest < Test::Unit::TestCase
  fixtures :permissions
  def test_truth
    assert_kind_of Permission, permissions(:first)
  end
end
