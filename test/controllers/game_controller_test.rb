require "test_helper"

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should be get index" do
    set_user

    get games_path(sports(:one)), params: { lat: 10, lon: -90 }
    assert_response :success
  end

  test "should be get show" do
    set_user

    get game_path(games(:one))
    assert_response :success
  end

  test "should be get new" do
    set_user

    get new_game_path
    assert_response :success
  end

  test "should be create game" do
    set_user

    assert_difference("Game.count") do
      post create_game_path, params: { game: {
          sport_id: sports(:one).id,
          start_date: DateTime.current,
          end_date: Date.current.tomorrow,
          info: "se pá",
          address: "nós vamos",
          latitude: 10.8988,
          longitude: 37.6821
        }
      }
    end

    assert_response :redirect
    assert_equal "Game created successfully", flash[:notice]
  end

  test "should not be create game without latitude and longitude" do
    set_user

    assert_no_difference("Game.count") do
      post create_game_path, params: { game: {
          sport_id: sports(:one).id,
          start_date: DateTime.current,
          end_date: Date.current.tomorrow,
          info: "se pá",
          address: "nós vamos",
          latitude: nil,
          longitude: nil      
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "should not be create game without start date" do
    set_user

    assert_no_difference("Game.count") do
      post create_game_path, params: { game: {
          sport_id: sports(:one).id,
          start_date: nil,
          end_date: Date.current.tomorrow,
          info: "se pá",
          address: "nós vamos",
          latitude: 10.8988,
          longitude: 37.6821
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "should not be create game without end date" do
    set_user

    assert_no_difference("Game.count") do
      post create_game_path, params: { game: {
          sport_id: sports(:one).id,
          start_date: DateTime.current,
          end_date: nil,
          info: "se pá",
          address: "nós vamos",
          latitude: 10.8988,
          longitude: 37.6821      
        }
      }
    end
    assert_response :unprocessable_entity
  end

    test "should not be create game without address" do
    set_user

    assert_no_difference("Game.count") do
      post create_game_path, params: { game: {
          sport_id: sports(:one).id,
          start_date: DateTime.current,
          end_date: Date.current.tomorrow,
          info: "se pá",
          address: nil,
          latitude: 10.8988,
          longitude: 37.6821      
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "should be get edit" do
    set_user

    get edit_game_url(games(:one))
    assert_response :success
  end

  test "should be update game" do
    set_user

    game = games(:one)

    put update_game_path(game), params: { game: {
        sport_id: sports(:two).id,
        start_date: game.start_date,
        end_date: Date.current.tomorrow,
        info: "mudança",
        latitude: 10.231,
        longitude: -32.4324
      }
    }
    assert_response :redirect
    assert_redirected_to game_path(game)
    assert_equal "Game updated successfully", flash[:notice]
  end

  test "should be destoy" do
    set_user

    assert_difference("Game.count", -1) do
      delete destroy_game_path(games(:one))
    end
    assert_response :redirect
    assert_redirected_to root_path
    assert_equal "Game deleted successfully", flash[:notice]
  end
end
