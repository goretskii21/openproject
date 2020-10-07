require File.dirname(__FILE__) + '/../test_helper'
require 'welcome_controller'
class WelcomeController; def rescue_action(e) raise e end; end
class WelcomeControllerTest < Test::Unit::TestCase
  def setup
    @controller = WelcomeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  def test_truth
    assert true
  end
end
