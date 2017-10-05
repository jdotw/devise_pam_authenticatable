Devise - PAM Authentication
===========================

devise\_pam\_authenticatable is a Devise (http://github.com/plataformatec/devise)
extension for authenticating using PAM (Pluggable Authentication Modulues)
via the rpam gem.

This allows you to authenticate against the local hosts authentication
system including local account usernames and passwords.

There are obvious security risks with using PAM authentication via a
web-based application. Make sure you at least use SSL to keep usernames and
passwords encrypted via HTTPS.

Installation
------------

In the Gemfile for your application:

    gem "devise\_pam\_authenticatable"

Or, to use the latest from github:

    gem "devise_pam_authenticatable", :git => "git://github.com/jwilson511/devise_pam_authenticatable.git"

Setup
-----

The devise_pam_authenticatable extension can use a username or extract the name from a special email address (suffix can be choosen)
username field and email field are configurable

In your Devise model, ensure the following is present:

    class User < ActiveRecord::Base

      devise :pam_authenticatable, pam_service: "system-auth", pam_suffix: "foo"

      # Setup accessible (or protected) attributes for your model
      attr_accessible :password, :<username or email field>

    end

pam_service: "system-auth" is optional. By default the pam service specified in config.pam_default_service is used.
pam_suffix: "foo" is optional. By default the pam email extraction suffix specified in config.pam_default_suffix is used.

Options:
  config.pam_default_service = "rpam"
  config.pam_default_suffix = nil # extraction disabled by default
  #config.pam_default_suffix = "pam" # username@pam = username
  config.emailfield = "email" # set emailfield
  config.usernamefield = "username" # set to nil to disable username (only email extraction)

References
----------

* [Devise](http://github.com/plataformatec/devise)
* [Warden](http://github.com/hassox/warden)


Released under the MIT license

Copyright (c) 2011 James Wilson, LithiumCorp Pty Ltd
