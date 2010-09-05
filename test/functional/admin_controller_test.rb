require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "admin index route" do
    assert_routing '/admin', { :controller => "admin", :action => "index" }
  end

  test "index without user" do
    get :index
    assert_redirected_to root_path
    assert_not_nil flash[:error]
  end
end
