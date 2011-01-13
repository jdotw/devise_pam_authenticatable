require 'rpam' 
include Rpam

module Devise

  module PamAdapter

    def self.valid_credentials?(username, password)
      if Rails.env.test? && username = 'testadmin' && password == 'test' then
        # If we're running in the test environment then return true
        # if the username is testadmin and password is test
        return true;
      end
      authpam(username, password)
    end

  end

end
