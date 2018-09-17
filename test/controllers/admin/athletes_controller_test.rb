require 'test_helper'

class Admin::AthletesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @athlete = athletes(:one)
  end

  test "should get index" do
    get admin_athletes_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_athlete_url
    assert_response :success
  end

  test "should create athlete" do
    assert_difference('Athlete.count') do
      post admin_athletes_url, params: { athlete: {  } }
    end

    assert_redirected_to athlete_url(Athlete.last)
  end

  test "should show athlete" do
    get admin_athlete_url(@athlete)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_athlete_url(@athlete)
    assert_response :success
  end

  test "should update athlete" do
    patch admin_athlete_url(@athlete), params: { athlete: {  } }
    assert_redirected_to athlete_url(@athlete)
  end

  test "should destroy athlete" do
    assert_difference('Athlete.count', -1) do
      delete admin_athlete_url(@athlete)
    end

    assert_redirected_to admin_athletes_url
  end
end
