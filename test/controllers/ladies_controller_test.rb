require 'test_helper'

class LadiesControllerTest < ActionController::TestCase
  setup do
    @lady = ladies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ladies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lady" do
    assert_difference('Lady.count') do
      post :create, lady: { mission_id: @lady.mission_id, source_id: @lady.source_id, target_id: @lady.target_id }
    end

    assert_redirected_to lady_path(assigns(:lady))
  end

  test "should show lady" do
    get :show, id: @lady
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lady
    assert_response :success
  end

  test "should update lady" do
    patch :update, id: @lady, lady: { mission_id: @lady.mission_id, source_id: @lady.source_id, target_id: @lady.target_id }
    assert_redirected_to lady_path(assigns(:lady))
  end

  test "should destroy lady" do
    assert_difference('Lady.count', -1) do
      delete :destroy, id: @lady
    end

    assert_redirected_to ladies_path
  end
end
