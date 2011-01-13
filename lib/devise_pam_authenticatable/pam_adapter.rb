require 'rpam' 
include Rpam

module Devise

  module PamAdapter

    def self.valid_credentials?(username, password)
      authpam(username, password)
    end

  end

end
