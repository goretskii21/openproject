require File.dirname(__FILE__) + '/../test_helper'
class RoleTest < Test::Unit::TestCase
  fixtures :roles
  def test_truth
    assert_kind_of Role, roles(:first)
  end
end
