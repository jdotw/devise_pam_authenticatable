require 'devise'
require 'rpam2'

require 'devise_pam_authenticatable/model'
require 'devise_pam_authenticatable/strategy'
module Devise
  mattr_accessor :pam_default_service
  @@pam_default_service = "rpam"
  mattr_accessor :pam_default_suffix
  @@pam_default_suffix = nil
  mattr_accessor :emailfield
  @@emailfield = "email"
  mattr_accessor :usernamefield
  @@usernamefield = "username"
end
Devise.add_module(:pam_authenticatable,
                  :route => :session,
                  :strategy   => true,
                  :controller => :sessions,
                  :model => "devise_pam_authenticatable/model")
