class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def azure_activedirectory_v2
    @user = User.from_omniauth(auth_data)

    if @user.persisted?
      flash[:notice] = "You're logged in"
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = @user.errors.full_messages.join("\n")
      redirect_to new_user_session_path
    end
  end

  def google_oauth2
    @user = User.from_omniauth(auth_data)

    if @user.persisted?
      flash[:notice] = "You're logged in"
      redirect_to root_path
    else
      flash[:alert] = @user.errors.full_messages.join("\n")
      redirect_to root_path
    end
  end

  protected

  def after_omniauth_failure_path_for(_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  private

  def auth_data
    @auth_data ||= request.env['omniauth.auth']
  end
end
