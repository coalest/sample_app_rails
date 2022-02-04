require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid params dont get saved to db" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  '',
                                         email: 'user@invalid',
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid inputs do get saved to db" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  'Testy McGee',
                                         email: 'user@valid.com',
                                         password:              "foobarbaz",
                                         password_confirmation: "foobarbaz" } }
    end
    follow_redirect!
    assert_template "users/show"
    assert is_logged_in?
    assert_not flash.empty?
  end
end
