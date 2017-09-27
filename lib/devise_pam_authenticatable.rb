require 'devise'

require 'devise_pam_authenticatable/model'
require 'devise_pam_authenticatable/strategy'

Devise.add_module(:pam_authenticatable,
                  :route => :session,
                  :strategy   => true,
                  :controller => :sessions,
                  :model => "devise_pam_authenticatable/model")
