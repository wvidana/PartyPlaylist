class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:current_user_id] = user.id
    session["devise.spotify_data"] = request.env["omniauth.auth"]
    sign_in_and_redirect user
    set_flash_message(:notice, :success, :kind => "Spotify") if is_navigational_format?
  end

  def failure
    puts "SOME FAILURE"
    flash.now "SPOTIFY LOGIN FAILURE"
    redirect_to root_path
  end

  def after_sign_in_path_for(user)
    result = user_path user.id
    puts "THIS IS THE AFTER SIGN IN PATH FOR"
    pp result
    result
  end
end