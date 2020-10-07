require File.dirname(__FILE__) + '/../test_helper'
require 'reports_controller'
class ReportsController; def rescue_action(e) raise e end; end
class ReportsControllerTest < Test::Unit::TestCase
  def setup
    @controller = ReportsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  def test_truth
    assert true
  end
end
