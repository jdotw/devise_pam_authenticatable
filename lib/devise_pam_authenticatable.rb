require 'devise'

$: << File.expand_path("..", __FILE__)

require 'devise_pam_authenticatable/model'
require 'devise_pam_authenticatable/strategy'
require 'devise_pam_authenticatable/routes'
require 'devise_pam_authenticatable/pam_adapter'

Devise.add_module(:pam_authenticatable, :strategy => true, :model => "devise_pam_authenticatable/model", :route => true)
