require 'test_helper'

class PlayerAssignmentsControllerTest < ActionController::TestCase
  setup do
    @player_assignment = player_assignments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:player_assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create player_assignment" do
    assert_difference('PlayerAssignment.count') do
      post :create, player_assignment: { game_id: @player_assignment.game_id, player_id: @player_assignment.player_id, role_id: @player_assignment.role_id, seat_number: @player_assignment.seat_number }
    end

    assert_redirected_to player_assignment_path(assigns(:player_assignment))
  end

  test "should show player_assignment" do
    get :show, id: @player_assignment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @player_assignment
    assert_response :success
  end

  test "should update player_assignment" do
    patch :update, id: @player_assignment, player_assignment: { game_id: @player_assignment.game_id, player_id: @player_assignment.player_id, role_id: @player_assignment.role_id, seat_number: @player_assignment.seat_number }
    assert_redirected_to player_assignment_path(assigns(:player_assignment))
  end

  test "should destroy player_assignment" do
    assert_difference('PlayerAssignment.count', -1) do
      delete :destroy, id: @player_assignment
    end

    assert_redirected_to player_assignments_path
  end
end
