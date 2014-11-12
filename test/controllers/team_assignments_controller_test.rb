require 'test_helper'

class TeamAssignmentsControllerTest < ActionController::TestCase
  setup do
    @team_assignment = team_assignments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_assignment" do
    assert_difference('TeamAssignment.count') do
      post :create, team_assignment: { pass: @team_assignment.pass, player_assignment_id: @team_assignment.player_assignment_id, team_id: @team_assignment.team_id }
    end

    assert_redirected_to team_assignment_path(assigns(:team_assignment))
  end

  test "should show team_assignment" do
    get :show, id: @team_assignment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @team_assignment
    assert_response :success
  end

  test "should update team_assignment" do
    patch :update, id: @team_assignment, team_assignment: { pass: @team_assignment.pass, player_assignment_id: @team_assignment.player_assignment_id, team_id: @team_assignment.team_id }
    assert_redirected_to team_assignment_path(assigns(:team_assignment))
  end

  test "should destroy team_assignment" do
    assert_difference('TeamAssignment.count', -1) do
      delete :destroy, id: @team_assignment
    end

    assert_redirected_to team_assignments_path
  end
end
