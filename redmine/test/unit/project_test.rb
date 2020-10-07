require File.dirname(__FILE__) + '/../test_helper'
class ProjectTest < Test::Unit::TestCase
  fixtures :projects
  def test_truth
    assert_kind_of Project, projects(:first)
  end
end
