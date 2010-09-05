require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup :activate_authlogic
  
  test "should get index" do
    UserSession.create Factory.build(:user)
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show user" do
    get :show, :id => Factory(:user).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => Factory(:user).id
    assert_response :success
  end

end
