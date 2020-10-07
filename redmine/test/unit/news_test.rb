require File.dirname(__FILE__) + '/../test_helper'
class NewsTest < Test::Unit::TestCase
  fixtures :news
  def test_truth
    assert_kind_of News, news(:first)
  end
end
