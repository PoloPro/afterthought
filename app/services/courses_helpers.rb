class CoursesHelpers

  def self.get_course_info(search_term)
    info = {}
    course = Course.find_by(title: search_term)
    course = Course.find_by(description: search_term) if course.nil?
    info["course_title"] = course.title
    info["course_description"] = course.description
    info["course_id"] = course.id
    info["course_path"] = "/courses/#{course.id}"
    info
  end
end
