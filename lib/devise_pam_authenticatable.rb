require 'devise'

require 'devise_pam_authenticatable/model'
require 'devise_pam_authenticatable/strategy'
module Devise
  mattr_accessor :servicename
  @@servicename = "rpam"
  mattr_accessor :emailextractsuffix
  @@emailextractsuffix = nil
end
Devise.add_module(:pam_authenticatable,
                  :route => :session,
                  :strategy   => true,
                  :controller => :sessions,
                  :model => "devise_pam_authenticatable/model")
