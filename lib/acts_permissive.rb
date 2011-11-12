#require 'simplecov'
#SimpleCov.start 'rails'

require 'uuidtools'
require 'acts_permissive/version'
require 'acts_permissive/membership'
require 'acts_permissive/membership_container'
require 'acts_permissive/circle'
require 'acts_permissive/exceptions'

module ActsPermissive
  autoload :UserScopes,         'acts_permissive/user_scopes'
  autoload :PermissiveLib,      'acts_permissive/permissive_lib'
  autoload :PermissiveObject,   'acts_permissive/permissive_object'
  autoload :PermissiveUser,     'acts_permissive/permissive_user'

  require 'acts_permissive/railtie' if defined?(Rails) && Rails::VERSION::MAJOR >= 3
end

ActiveRecord::Base.send :include, ActsPermissive::PermissiveUser
ActiveRecord::Base.send :include, ActsPermissive::PermissiveObject