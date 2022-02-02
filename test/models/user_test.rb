require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "       "
    assert_not @user.valid?
  end

  test "name should not be too short" do
    @user.name = "joe"
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "       "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "valid emails should be valid" do
    valid_emails = %w[user@example.com USER@foo.com A_US_ER@foo.bar.org
                      first.last@foo.jp alice+bob@baz.cn]
    valid_emails.each do |address|
      @user.email = address
      assert @user.valid?, "#{address} should be valid"
    end
  end

  test "invalid emails should be invalid" do
    invalid_emails = %w[user@example,com user_at_foo.org user.name@example.
                        foo@bar_baz.com foo@bar+baz.com]
    invalid_emails.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address} should be invalid"
    end
  end

  test "emails should be unique" do
    @user.save
    duplicate_user = @user.dup
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower case" do
    mixed_case = "uSeR@eXaMpLe.coM"
    @user.email = mixed_case
    @user.save
    assert_equal mixed_case.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = "     "
    @user.password_confirmation = "     "
    assert_not @user.valid?
  end

  test "password should not be too short" do
    @user.password = 'a' * 5
    @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end
end
