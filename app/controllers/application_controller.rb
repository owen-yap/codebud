class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user

  # Pundit: white-list approach- means all is banne dunless authorised
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name photo username tutor skill_ids])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name photo username tutor])
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def set_user
    cookies[:user_id] = current_user ? current_user.id : 'guest'
  end
end
