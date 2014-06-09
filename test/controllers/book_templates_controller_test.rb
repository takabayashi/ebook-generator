require 'test_helper'

class BookTemplatesControllerTest < ActionController::TestCase
  setup do
    @book_template = book_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:book_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book_template" do
    assert_difference('BookTemplate.count') do
      post :create, book_template: { title: @book_template.title }
    end

    assert_redirected_to book_template_path(assigns(:book_template))
  end

  test "should show book_template" do
    get :show, id: @book_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book_template
    assert_response :success
  end

  test "should update book_template" do
    patch :update, id: @book_template, book_template: { title: @book_template.title }
    assert_redirected_to book_template_path(assigns(:book_template))
  end

  test "should destroy book_template" do
    assert_difference('BookTemplate.count', -1) do
      delete :destroy, id: @book_template
    end

    assert_redirected_to book_templates_path
  end
end
