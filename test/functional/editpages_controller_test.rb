require 'test_helper'

class EditpagesControllerTest < ActionController::TestCase
  setup do
    @editpage = editpages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:editpages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create editpage" do
    assert_difference('Editpage.count') do
      post :create, editpage: { content: @editpage.content }
    end

    assert_redirected_to editpage_path(assigns(:editpage))
  end

  test "should show editpage" do
    get :show, id: @editpage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @editpage
    assert_response :success
  end

  test "should update editpage" do
    put :update, id: @editpage, editpage: { content: @editpage.content }
    assert_redirected_to editpage_path(assigns(:editpage))
  end

  test "should destroy editpage" do
    assert_difference('Editpage.count', -1) do
      delete :destroy, id: @editpage
    end

    assert_redirected_to editpages_path
  end
end
