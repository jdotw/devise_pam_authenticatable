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

      def servicename
        self.class.servicename
      end

      def extract_name(attributes)
        return attributes[:username] if attributes[:username].present?
        return nil unless attributes[:email].present?
        ret = attributes[:email].index("@#{self.class.emailextractsuffix}")
        attributes[:email].slice(0, ret-1) if ret else nil
      end

      # Checks if a resource is valid upon authentication.
      def valid_pam_authentication?(password)
        Rpam2.authpam(servicename, self.username, password)
      end

      module ClassMethods
        Devise::Models.config(self, :servicename, :emailextractsuffix)
        def authenticate_with_pam(attributes={})
          username = extract_name attributes
          return nil unless username

          resource = scoped.where(:username => username).first
          if resource.blank?
            resource = new
            resource[:username] = username
            resource[:password] = attributes[:password]
          end

          if resource.try(:valid_pam_authentication?, attributes[:password])
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
