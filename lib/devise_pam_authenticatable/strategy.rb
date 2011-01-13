require 'devise/strategies/base'

module Devise
  module Strategies
    class PamAuthenticatable < Base
      
      def valid?
        valid_controller? && valid_params? && mapping.to.respond_to?(:authenticate_with_pam)
      end
      
      def authenticate!
        if resource = mapping.to.authenticate_with_pam(params[scope])
          success!(resource)
        else
          fail(:invalid)
        end
      end
      
      protected

        def valid_controller?
          params[:controller] == 'devise/sessions'
        end

        def valid_params?
          params[scope] && params[scope][:password].present?
        end

    end
  end
end

Warden::Strategies.add(:pam_authenticatable, Devise::Strategies::PamAuthenticatable)
