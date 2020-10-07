require File.dirname(__FILE__) + '/../test_helper'
class CustomFieldTest < Test::Unit::TestCase
  fixtures :custom_fields
  def test_truth
    assert_kind_of CustomField, custom_fields(:first)
  end
end
