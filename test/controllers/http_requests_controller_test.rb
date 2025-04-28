require "test_helper"

class HttpRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should create http request with GET method" do
    assert_difference('HttpRequest.count') do
      get "/test", params: { test: "value" }, headers: { "X-Test": "test-header" }
    end

    request = HttpRequest.last
    assert_equal "GET", request.method
    assert_equal "http://www.example.com/test?test=value", request.url
    assert_equal({ "test" => "value" }, request.params)
    assert_equal "test-header", request.headers["X-Test"]
    assert_equal "127.0.0.1", request.ip
    assert_redirected_to http_request_path(request)
  end

  test "should create http request with POST method and JSON body" do
    test_data = { data: "test" }
    
    assert_difference('HttpRequest.count') do
      post "/api/test", 
           params: test_data.to_json,
           headers: { 
             "X-Test": "test-header",
             "Accept": "application/json",
             "Content-Type": "application/json"
           }
    end

    request = HttpRequest.last
    assert_equal "POST", request.method
    assert_equal "http://www.example.com/api/test", request.url
    assert_equal test_data.to_json, request.body
    assert_equal "application/json", request.headers["Content-Type"]
    assert_equal "test-header", request.headers["X-Test"]
    assert_equal "127.0.0.1", request.ip
    
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal request.id, json_response["id"]
    assert_equal test_data[:data], JSON.parse(json_response["body"])["data"]
  end
end
