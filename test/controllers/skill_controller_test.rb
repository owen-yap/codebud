require 'test_helper'

class SkillControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get skill_new_url
    assert_response :success
  end

end
