require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Searchkick.enable_callbacks
    sign_in users(:one)
    @course = courses(:one)
  end

  def teardown
    Searchkick.disable_callbacks
  end

  test "should get index" do
    get api_v1_courses_url, as: :json
    assert_response :success
  end

  test "should create course" do
    assert_difference("Course.count") do
      post api_v1_courses_url, params: { course: { author: @course.author, category_id: @course.category_id, name: @course.name, state: @course.state } }, as: :json
    end

    assert_response :created
  end

  test "should show course" do
    get api_v1_course_url(@course), as: :json
    assert_response :success
  end

  test "should update course" do
    patch api_v1_course_url(@course), params: { course: { author: @course.author, category_id: @course.category_id, name: @course.name, state: @course.state } }, as: :json
    assert_response :success
  end

  test "should destroy course" do
    assert_difference("Course.count", -1) do
      delete api_v1_course_url(@course), as: :json
    end

    assert_response :no_content
  end
end
