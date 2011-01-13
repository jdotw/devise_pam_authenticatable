require 'devise/strategies/base'

module Devise
  module Strategies
    class PamAuthenticatable < Base
      
      def valid?
        puts "Asked if valid"
        valid_controller? && valid_params? && mapping.to.respond_to?(:authenticate_with_pam)
      end
      
      def authenticate!
        puts "Asked to authenticate"
        if resource = mapping.to.authenticate_with_pam(params[scope])
          success!(resource)
        else
          fail(:invalid)
        end
      end
      
      protected

        def valid_controller?
          puts "Controller is #{params[:controller]}"
          params[:controller] == 'devise/sessions'
        end

        def valid_params?
          puts "Scope is #{params[scope]}"
          params[scope] && params[scope][:password].present?
        end

    end
  end
end

Warden::Strategies.add(:pam_authenticatable, Devise::Strategies::PamAuthenticatable)
