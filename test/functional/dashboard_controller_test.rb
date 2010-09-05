require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "dashboard index route" do
    assert_routing '/', { :controller => 'dashboard', :action => 'index' }
  end

  test "index without user" do
    get :index
    assert_redirected_to login_path
    assert_not_nil flash[:error]
  end
end
