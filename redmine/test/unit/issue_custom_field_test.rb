require File.dirname(__FILE__) + '/../test_helper'
class IssueCustomFieldTest < Test::Unit::TestCase
  fixtures :issue_custom_fields
  def test_truth
    assert_kind_of IssueCustomField, issue_custom_fields(:first)
  end
end
