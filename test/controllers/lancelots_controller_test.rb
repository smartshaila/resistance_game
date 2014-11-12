require 'test_helper'

class LancelotsControllerTest < ActionController::TestCase
  setup do
    @lancelot = lancelots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lancelots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lancelot" do
    assert_difference('Lancelot.count') do
      post :create, lancelot: { mission_id: @lancelot.mission_id, switched: @lancelot.switched }
    end

    assert_redirected_to lancelot_path(assigns(:lancelot))
  end

  test "should show lancelot" do
    get :show, id: @lancelot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lancelot
    assert_response :success
  end

  test "should update lancelot" do
    patch :update, id: @lancelot, lancelot: { mission_id: @lancelot.mission_id, switched: @lancelot.switched }
    assert_redirected_to lancelot_path(assigns(:lancelot))
  end

  test "should destroy lancelot" do
    assert_difference('Lancelot.count', -1) do
      delete :destroy, id: @lancelot
    end

    assert_redirected_to lancelots_path
  end
end
