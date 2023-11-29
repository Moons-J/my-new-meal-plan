class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # before_action :set_time_zone, if: :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :user_name, :birthday, :height, :exercise_level, :weight ])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :user_name, :birthday, :height, :exercise_level, :weight ])
  end

  # private

  # def set_time_zone
  #   Time.zone = current_user.time_zone
  # end
end
