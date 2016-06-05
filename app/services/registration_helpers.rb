class RegistrationHelpers

  def self.email_success(user)
    RegistrationMailer.registration_confirmation(user).deliver_now
  end

  def self.capitalize_name(user)
    user.name = user.name.titleize
  end

end
