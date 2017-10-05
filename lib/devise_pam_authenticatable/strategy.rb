require 'devise/strategies/base'

class Devise::Strategies::PamAuthenticatable < Devise::Strategies::Authenticatable

  def authenticate!
    if resource = mapping.to.authenticate_with_pam(params[scope])
      success!(resource)
    else
      fail(:invalid)
    end
  end

end

Warden::Strategies.add(:pam_authenticatable, Devise::Strategies::PamAuthenticatable)
