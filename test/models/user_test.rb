require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    image = Rack::Test::UploadedFile.new(File.join(ActionDispatch::IntegrationTest.file_fixture_path, "boy.jpg"), "image/png")
    @user = User.new( 
      email: 'alexandre@hotmail.com',
      name: 'alexandre',
      username: 'alexandre',
      password_digest: 'alexandre',
      bio: 'I´m cool',
      avatar: image)
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'should be save'do
    assert_difference('User.count') do
      @user.save
    end
  end

  test 'should be destroy' do
    assert_difference('User.count', -1) do
      users(:one).destroy
    end
  end

  test 'should be invalid without name' do
    @user.name = nil
    assert_not @user.valid?

    assert_no_difference('User.count') do
      @user.save
    end
  end

  test 'the name should be greater than or equal to 3 characters' do
    @user.name = 'te'
    assert @user.invalid?

    assert_no_difference('User.count') do
      @user.save
    end

    assert_equal ['is too short (minimum is 3 characters)'], @user.errors[:name]
    assert_operator @user.name.size, :<=, 3

    @user.name = 'tes'
    assert @user.valid?
    assert_operator @user.name.size, :>=, 3
  end

  test 'the name should be less than or equal to 20 characters' do
    @user.name = 'I Will Now Rest These Wings For Flying'
    assert @user.invalid?

    assert_no_difference('User.count') do
      @user.save
    end

    assert_equal ['is too long (maximum is 20 characters)'], @user.errors[:name]
    assert_operator @user.name.size, :>=, 20

    @user.name = 'I Will Now Rest'
    assert @user.valid?
    assert_operator @user.name.size, :<=, 20
  end

  test 'should be invalid without username' do
    @user.username = nil
    assert_not @user.valid?

    assert_no_difference('User.count') do
      @user.save
    end
  end

  test 'should not be save with existing username' do
    @user.username = 'examples'
    assert_not @user.valid?
    
    assert_no_difference('User.count') do
      @user.save
    end
  end

  test 'the username should be greater than or equal to 3 characters' do
    @user.username = 'te'
    assert_no_difference('User.count') do
      assert @user.invalid?
    end

    assert_equal ["is too short (minimum is 3 characters)"], @user.errors[:username]
    assert_operator @user.username.size, :<=, 3

    @user.username = 'tes'
    assert @user.valid?
    assert_operator @user.username.size, :>=, 3
  end

  test 'the username should be less than or equal to 20 characters' do
    @user.username = 'I Will Now Rest These Wings For Flying'
    assert_no_difference('User.count') do
      assert @user.invalid?
    end

    assert_equal ['is too long (maximum is 20 characters)'], @user.errors[:username]
    assert_operator @user.username.size, :>=, 20

    @user.username = 'I Will Now Rest'
    assert @user.valid?
    assert_operator @user.username.size, :<=, 20
  end

  # Fix
  #regex username /\^[\w-]*[A-Za-z]+[\w-]*$/
  # test 'should be invalid username via regex' do
  #   @user.username = 'man.'
  #   assert_no_match /\^[\w-]*[A-Za-z]+[\w-]*$/, @user.username
  # end

  test 'should be invalid without email' do
    @user.email = nil
    assert_not @user.valid?

    assert_no_difference('User.count') do
      @user.save
    end
  end

  test 'should not be save with existing email' do
    @user.email = 'fried@example.com'
    assert_not @user.valid?
    
    assert_no_difference('User.count') do
      @user.save
    end
  end

  # regex email /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  test 'should be invalid email via regex' do
    @user.email = 'man.'
    assert_no_match /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, @user.email
  end

  test 'should be invalid without password' do
    @user.password_digest = nil

    assert @user.invalid?

    assert_no_difference('User.count') do
      @user.save
    end

    assert_equal ["can't be blank"], @user.errors[:password]

    @user.password = 'opacomovai'

    assert @user.valid?
  end

  test 'the bio should be less than or equal to 300 characters' do
    @user.bio = ('ah!' * 100) + 'ops'

    assert @user.invalid?

    assert_no_difference('User.count') do
      @user.save
    end

    assert_equal ['is too long (maximum is 300 characters)'], @user.errors[:bio]
    assert_operator @user.bio.size, :>=, 300

    @user.bio = 'opa como vai'

    assert @user.valid?
    assert_operator @user.bio.size, :<=, 300
  end
end
