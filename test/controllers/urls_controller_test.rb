require 'test_helper'

class UrlsControllerTest < ActionController::TestCase
  setup do
    @url = urls(:one)
    @url_three = urls(:three)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:urls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create url" do
    assert_difference('Url.count') do
      post :create, url: { long_url: @url.long_url, short_url: @url.short_url }
    end

    assert_redirected_to url_path(assigns(:url))
  end

  test "should show url" do
    get :show, id: @url
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @url
    assert_response :success
  end

  test "should update url" do
    patch :update, id: @url, url: { long_url: @url.long_url, short_url: @url.short_url }
    assert_redirected_to url_path(assigns(:url))
  end

  test "should destroy url" do
    assert_difference('Url.count', -1) do
      delete :destroy, id: @url
    end
    assert_redirected_to urls_path
  end

  ## Test the url_shortener_api ##

  test "API returns an error when no parameters are given" do
    post :url_shortener_api
    assert_response :unprocessable_entity
    assert_match(/URL is required, but not present./, @response.body)
  end

  test "should create short url via API" do
    post :url_shortener_api, url: 'www.test.com'
    assert_response :success
    assert_match(/Short url created is:/, @response.body)
  end

  test "should create short url via API#2" do
    post :url_shortener_api, url: @url.long_url
    assert_response :success
    assert_match(/The corresponding long url is:/, @response.body)
  end

  test "should find a corresponding long_url" do
    post :url_shortener_api, url: 'MyString'
    assert_response :success
    assert_match(/The corresponding long url is:/, @response.body)
  end

  test "should create a short url for www.google.com" do
    post :url_shortener_api, url: @url_three.long_url
    assert_response :success
    assert_match(/Short url created is: tny\/3d3d042/, @response.body)
  end

end
