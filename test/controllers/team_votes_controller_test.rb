require 'test_helper'

class TeamVotesControllerTest < ActionController::TestCase
  setup do
    @team_vote = team_votes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_vote" do
    assert_difference('TeamVote.count') do
      post :create, team_vote: { approve: @team_vote.approve, player_assignment_id: @team_vote.player_assignment_id, team_id: @team_vote.team_id }
    end

    assert_redirected_to team_vote_path(assigns(:team_vote))
  end

  test "should show team_vote" do
    get :show, id: @team_vote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @team_vote
    assert_response :success
  end

  test "should update team_vote" do
    patch :update, id: @team_vote, team_vote: { approve: @team_vote.approve, player_assignment_id: @team_vote.player_assignment_id, team_id: @team_vote.team_id }
    assert_redirected_to team_vote_path(assigns(:team_vote))
  end

  test "should destroy team_vote" do
    assert_difference('TeamVote.count', -1) do
      delete :destroy, id: @team_vote
    end

    assert_redirected_to team_votes_path
  end
end
