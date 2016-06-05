require 'test_helper'

class InstructorRegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get instructor_registrations_new_url
    assert_response :success
  end

end
