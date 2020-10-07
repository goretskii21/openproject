require File.dirname(__FILE__) + '/../test_helper'
require 'account_controller'
class AccountController; def rescue_action(e) raise e end; end
class AccountControllerTest < Test::Unit::TestCase
  def setup
    @controller = AccountController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  def test_truth
    assert true
  end
end
