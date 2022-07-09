require "test_helper"

class GameTest < ActiveSupport::TestCase
  def setup
    @game = Game.new(
      user_id: users(:one).id,
      sport_id: sports(:one).id,
      start_date: DateTime.current,
      end_date: DateTime.current,
      info: 'É uma história sem fim.',
      address: 'Você já ouviu falar?',
      localization: 'POINT(-122 32)'
      )
  end

  test "should be valid" do
    assert @game.valid?
  end

  test "should be save" do
    assert_difference("Game.count") do
      @game.save
    end
  end

  test "should be destroy" do
    assert_difference("Game.count") do
      @game.save
    end

    assert_difference("Game.count", -1) do
      @game.destroy
    end
  end

  test "should be invalid without start date" do
    @game.start_date = nil
    assert @game.invalid?
  end

  test "should not be valid with invalid start date" do
    @game.start_date = 'not Today'
    assert @game.invalid?
  end

  test "should be invalid without end date" do
    @game.end_date = nil
    assert @game.invalid?
  end

  test "should not be valid with invalid end date" do
    @game.end_date = 'not Today'
    assert @game.invalid?
  end

  test "should be invalid without localization" do
    @game.localization = nil
    assert @game.invalid?
  end

  test "should be invalid without address" do
    @game.address = nil
    assert @game.invalid?
  end

  test "end date cannot be before start date" do
    @game.end_date = '10/02/2000 10:00'
    assert @game.invalid?
  end

  test 'the info should be less than or equal to 300 characters' do
    @game.info =  ('ah!' * 100) + 'ops'
    assert @game.invalid?

    assert_no_difference('Game.count') do
      @game.save
    end

    assert_equal ['is too long (maximum is 300 characters)'], @game.errors[:info]
    assert_operator @game.info.size, :>=, 20

    @game.info = 'I Will Now Rest'
    assert @game.valid?
    assert_operator @game.info.size, :<=, 20
  end
end
