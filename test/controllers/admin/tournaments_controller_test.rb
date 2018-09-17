require 'test_helper'

class Admin::TournamentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tournament = tournaments(:one)
  end

  test "should get index" do
    get admin_tournaments_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_tournament_url
    assert_response :success
  end

  test "should create tournament" do
    assert_difference('Tournament.count') do
      post admin_tournaments_url, params: { tournament: {  } }
    end

    assert_redirected_to tournament_url(Tournament.last)
  end

  test "should show tournament" do
    get admin_tournament_url(@tournament)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_tournament_url(@tournament)
    assert_response :success
  end

  test "should update tournament" do
    patch admin_tournament_url(@tournament), params: { tournament: {  } }
    assert_redirected_to tournament_url(@tournament)
  end

  test "should destroy tournament" do
    assert_difference('Tournament.count', -1) do
      delete admin_tournament_url(@tournament)
    end

    assert_redirected_to admin_tournaments_url
  end
end
