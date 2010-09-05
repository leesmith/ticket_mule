require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  setup :activate_authlogic

  def setup
    UserSession.create Factory.build(:user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show contact" do
    get :show, :id => Factory(:contact).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => Factory(:contact).id
    assert_response :success
  end
end
