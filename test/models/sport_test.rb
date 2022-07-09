require "test_helper"

class SportTest < ActiveSupport::TestCase
  def setup
    image = Rack::Test::UploadedFile.new(File.join(ActionDispatch::IntegrationTest.file_fixture_path, "ball.jpg"), "image/png")
    @sport = Sport.new( 
      name: 'alexandre',
      sport_image: image
      )
  end

  test 'should be valid' do
    assert @sport.valid?
  end

  test 'should be save' do
    assert_difference('Sport.count') do
      @sport.save
    end
  end

  test 'should be invalid without name' do
    @sport.name = nil
    assert_not @sport.valid?

    assert_no_difference('Sport.count') do
      @sport.save
    end
  end

  test 'should be destroy' do
    assert_difference('Sport.count', -1) do
      sports(:one).destroy
    end
  end

end
