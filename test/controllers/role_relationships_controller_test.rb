require 'test_helper'

class RoleRelationshipsControllerTest < ActionController::TestCase
  setup do
    @role_relationship = role_relationships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:role_relationships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create role_relationship" do
    assert_difference('RoleRelationship.count') do
      post :create, role_relationship: { revealed_allegiance: @role_relationship.revealed_allegiance, revealed_role_id: @role_relationship.revealed_role_id, role_id: @role_relationship.role_id }
    end

    assert_redirected_to role_relationship_path(assigns(:role_relationship))
  end

  test "should show role_relationship" do
    get :show, id: @role_relationship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @role_relationship
    assert_response :success
  end

  test "should update role_relationship" do
    patch :update, id: @role_relationship, role_relationship: { revealed_allegiance: @role_relationship.revealed_allegiance, revealed_role_id: @role_relationship.revealed_role_id, role_id: @role_relationship.role_id }
    assert_redirected_to role_relationship_path(assigns(:role_relationship))
  end

  test "should destroy role_relationship" do
    assert_difference('RoleRelationship.count', -1) do
      delete :destroy, id: @role_relationship
    end

    assert_redirected_to role_relationships_path
  end
end
