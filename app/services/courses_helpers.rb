class CoursesHelpers

  def self.get_course_info(search_term, current_user)
    course = Course.find_by(title: search_term)
    course = Course.find_by(description: search_term) if course.nil?
    CoursesHelpers.put_info_into_hash(course, current_user)
  end

  def self.not_course_instructor?(course_id, current_user)
    course = Course.find_by(id: course_id)
    course_instructors = course.instructors
    !course_instructors.include? (current_user)
  end

  def self.put_info_into_hash(course, current_user)
    {slugified_title: course.title.parameterize,
    title: course.title,
    description: course.description,
    courseId: course.id,
    coursePath: "/courses/#{course.id}",
    courseStudents: course.students.count,
    userClass: current_user.class.to_s}
  end
end
