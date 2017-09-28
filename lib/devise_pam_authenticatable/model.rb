require 'rpam2'

require 'devise_pam_authenticatable/strategy'

module Devise
  module Models
    module PamAuthenticatable
      def self.included(base)
        base.class_eval do
          extend ClassMethods
          attr_accessor :password
        end
      end

      def self.required_fields(klass)
        []
      end

      # Set password to nil
      def clean_up_passwords
        self.password = nil
      end

      def get_service
        if self.class.instance_variable_defined?("@pam_service")
          return self.class.pam_service
        else
          return ::Devise::pam_default_service
        end
      end

      def get_suffix
        if self.class.instance_variable_defined?("@pam_suffix")
          return self.class.pam_suffix
        else
          return ::Devise::pam_default_suffix
        end
      end

      def extract_name(email)
        return nil unless get_suffix
        email = email+"\n"
        pos = email.index("@#{get_suffix}\n")
        return email.slice(0, pos) if pos else return nil
      end

      # Checks if a resource is valid upon authentication.
      def valid_pam_authentication?(username, password)
        Rpam2.authpam(get_service, username, password)
      end

      module ClassMethods
        Devise::Models.config(self, :pam_service, :pam_suffix)

        def authenticate_with_pam(attributes={})
          if ::Devise::usernamefield && attributes[::Devise::usernamefield].present?
            resource = where(::Devise::usernamefield => attributes[::Devise::usernamefield]).first

            if resource.blank?
              resource = new
              resource[::Devise::usernamefield] = attributes[::Devise::usernamefield]
              resource.password = attributes[:password]
            end

            username = attributes[::Devise::usernamefield]
          elsif attributes[::Devise::emailfield].present?
            resource = where(::Devise::emailfield => attributes[::Devise::emailfield]).first

            if resource.blank?
              resource = new
              resource[::Devise::emailfield] = attributes[::Devise::emailfield]
              resource.password = attributes[:password]
            end

            username = resource.extract_name(attributes[::Devise::emailfield])
          else
            return nil
          end
          return nil unless username

          if resource.try(:valid_pam_authentication?, username, attributes[:password])
            resource.save if resource.new_record?
            return resource
          else
            return nil
          end
        end
      end
    end
  end
end
