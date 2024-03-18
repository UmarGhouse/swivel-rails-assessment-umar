require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Searchkick.enable_callbacks
    sign_in users(:one)
    @category = categories(:one)
  end

  def teardown
    Searchkick.disable_callbacks
  end

  test "should get index" do
    get api_v1_categories_url, as: :json
    assert_response :success
  end

  test "should create category" do
    @category.name = "MyString3"
    assert_difference("Category.count") do
      post api_v1_categories_url, params: { category: { name: @category.name, state: @category.state, vertical_id: @category.vertical_id } }, as: :json
    end

    assert_response :created
  end

  test "should show category" do
    get api_v1_category_url(@category), as: :json
    assert_response :success
  end

  test "should update category" do
    @category.name = "MyString3"
    patch api_v1_category_url(@category), params: { category: { name: @category.name, state: @category.state, vertical_id: @category.vertical_id } }, as: :json
    assert_response :success
  end

  test "should destroy category" do
    assert_difference("Category.count", -1) do
      delete api_v1_category_url(@category), as: :json
    end

    assert_response :no_content
  end
end
