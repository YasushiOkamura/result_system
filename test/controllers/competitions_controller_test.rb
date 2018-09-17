require 'test_helper'

class CompetitionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @competition = competitions(:one)
  end

  test "should get index" do
    get _competitions_url
    assert_response :success
  end

  test "should get new" do
    get new__competition_url
    assert_response :success
  end

  test "should create competition" do
    assert_difference('Competition.count') do
      post _competitions_url, params: { competition: {  } }
    end

    assert_redirected_to competition_url(Competition.last)
  end

  test "should show competition" do
    get _competition_url(@competition)
    assert_response :success
  end

  test "should get edit" do
    get edit__competition_url(@competition)
    assert_response :success
  end

  test "should update competition" do
    patch _competition_url(@competition), params: { competition: {  } }
    assert_redirected_to competition_url(@competition)
  end

  test "should destroy competition" do
    assert_difference('Competition.count', -1) do
      delete _competition_url(@competition)
    end

    assert_redirected_to _competitions_url
  end
end
