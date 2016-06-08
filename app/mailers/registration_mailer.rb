class RegistrationMailer < ApplicationMailer

  def registration_confirmation(user)
    @user = user
    
    attachments.inline['afterthought_logo.png'] = File.read('app/assets/images/afterthought_logo_darkpurple_medium.png')

    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registration Confirmation")
  end

end
