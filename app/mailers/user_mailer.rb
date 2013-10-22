class UserMailer < ActionMailer::Base
  default from: "laughter@hehemachine.com"
  def welcome(user)
  	@user = user
  	mail(:to => "#{@user.name} <#{@user.email}>", :subject => "Thanks for Registering")
  end
  
  def new_user_signup(user)
    @user = user
    mail(:to => "Ben Gruber <blgruber@gmail.com>", :subject => "New User Signed Up")
  end

  def following_you(user,follower)
    @user = user
    @follower = follower
    mail(:to => "#{@user.name} <#{@user.email}>", :subject => "#{@follower.name} is now following you")
  end

end
