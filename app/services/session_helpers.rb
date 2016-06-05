class SessionHelpers
  def self.student_user?(params)
    params.keys.include?("student")
  end
end
