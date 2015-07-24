require 'test_helper'

class MyfilesControllerTest < ActionController::TestCase
  setup do
    @myfile = myfiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:myfiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create myfile" do
    assert_difference('Myfile.count') do
      post :create, myfile: { file_md5: @myfile.file_md5, file_name: @myfile.file_name, file_path: @myfile.file_path }
    end

    assert_redirected_to myfile_path(assigns(:myfile))
  end

  test "should show myfile" do
    get :show, id: @myfile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @myfile
    assert_response :success
  end

  test "should update myfile" do
    patch :update, id: @myfile, myfile: { file_md5: @myfile.file_md5, file_name: @myfile.file_name, file_path: @myfile.file_path }
    assert_redirected_to myfile_path(assigns(:myfile))
  end

  test "should destroy myfile" do
    assert_difference('Myfile.count', -1) do
      delete :destroy, id: @myfile
    end

    assert_redirected_to myfiles_path
  end
end
