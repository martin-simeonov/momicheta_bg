require 'test_helper'

class BattlesControllerTest < ActionController::TestCase
  setup do
    @battle = battles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:battles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create battle" do
    assert_difference('Battle.count') do
      post :create, battle: { oponent1_id: @battle.oponent1_id, oponent1_votes: @battle.oponent1_votes, oponent2_id: @battle.oponent2_id, oponent2_votes: @battle.oponent2_votes }
    end

    assert_redirected_to battle_path(assigns(:battle))
  end

  test "should show battle" do
    get :show, id: @battle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @battle
    assert_response :success
  end

  test "should update battle" do
    patch :update, id: @battle, battle: { oponent1_id: @battle.oponent1_id, oponent1_votes: @battle.oponent1_votes, oponent2_id: @battle.oponent2_id, oponent2_votes: @battle.oponent2_votes }
    assert_redirected_to battle_path(assigns(:battle))
  end

  test "should destroy battle" do
    assert_difference('Battle.count', -1) do
      delete :destroy, id: @battle
    end

    assert_redirected_to battles_path
  end
end
