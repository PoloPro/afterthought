require 'test_helper'

class StudentRegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get student_registrations_new_url
    assert_response :success
  end

end
