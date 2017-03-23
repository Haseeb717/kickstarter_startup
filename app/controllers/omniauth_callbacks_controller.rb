class OmniauthCallbacksController < Devise::OmniauthCallbacksController   

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      flash[:alert] = "Could not authenticate you from Facebook because 'Invalid credentials'"
      redirect_to root_path
    end
  end

  def google_oauth2
     
    @user = User.from_google_omnioauth(request.env["omniauth.auth"])
 
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Google+") if is_navigational_format?
    else
      flash[:alert] = "Could not authenticate you from Google because 'Invalid credentials'"
      redirect_to root_path
    end
  end

end