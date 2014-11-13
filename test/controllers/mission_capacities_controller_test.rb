require 'test_helper'

class MissionCapacitiesControllerTest < ActionController::TestCase
  setup do
    @mission_capacity = mission_capacities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mission_capacities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mission_capacity" do
    assert_difference('MissionCapacity.count') do
      post :create, mission_capacity: { capacity: @mission_capacity.capacity, fail_count: @mission_capacity.fail_count, mission_number: @mission_capacity.mission_number, player_count: @mission_capacity.player_count }
    end

    assert_redirected_to mission_capacity_path(assigns(:mission_capacity))
  end

  test "should show mission_capacity" do
    get :show, id: @mission_capacity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mission_capacity
    assert_response :success
  end

  test "should update mission_capacity" do
    patch :update, id: @mission_capacity, mission_capacity: { capacity: @mission_capacity.capacity, fail_count: @mission_capacity.fail_count, mission_number: @mission_capacity.mission_number, player_count: @mission_capacity.player_count }
    assert_redirected_to mission_capacity_path(assigns(:mission_capacity))
  end

  test "should destroy mission_capacity" do
    assert_difference('MissionCapacity.count', -1) do
      delete :destroy, id: @mission_capacity
    end

    assert_redirected_to mission_capacities_path
  end
end
