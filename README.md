Devise - PAM Authentication
===========================

devise_pam_authenticatable is a Devise (http://github.com/plataformatec/devise) 
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

    gem "devise_pam_authenticatable"

Or, to use the latest from github:

    gem "devise_pam_authenticatable", :git => "git://github.com/jwilson511/devise_pam_authenticatable.git"

Setup
-----

The devise_pam_authenticatable extension required the use of 'username' as
the login credential (not email). Make sure your Devise model is using
'username' and not 'email'. 

In your Devise model, ensure the following is present:

    class User < ActiveRecord::Base

      devise :pam_authenticatable

      # Setup accessible (or protected) attributes for your model
      attr_accessible :username, :password

    end


References
----------

* [Devise](http://github.com/plataformatec/devise)
* [Warden](http://github.com/hassox/warden)


Released under the MIT license

Copyright (c) 2011 James Wilson, LithiumCorp Pty Ltd
