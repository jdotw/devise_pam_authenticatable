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

      # Set password to nil
      def clean_up_passwords
        self.password = nil
      end

      # Checks if a resource is valid upon authentication.
      def valid_pam_authentication?(username, password)
        Rpam2.authpam(::Devise::servicename, username, password)
      end

      module ClassMethods
        Devise::Models.config(self, :servicename, :emailextractsuffix)
        def extract_name(email)
          email = email+"\n"
          pos = email.index("@#{::Devise::emailextractsuffix}\n")
          ret = email.slice(0, pos) if pos else nil
          ret
        end
        def has_name(attributes)
          return true if attributes[:username].present? && !::Devise::emailextractsuffix
          return true if attributes[:email].present? && ::Devise::emailextractsuffix
          false
        end
        def authenticate_with_pam(attributes={})
          return nil unless has_name(attributes)

          if attributes[:username].present? || !::Devise::emailextractsuffix
            resource = where(:username => attributes[:username]).first
            if resource.blank?
              resource = new
              resource[:username] = attributes[:username]
              resource.password = attributes[:password]
            end
            username = attributes[:username]
          else
            resource = where(:email => attributes[:email]).first
            if resource.blank?
              resource = new
              resource[:email] = attributes[:email]
              resource.password = attributes[:password]
            end
            username = extract_name(attributes[:email])
          end

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
