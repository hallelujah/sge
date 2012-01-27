source "http://rubygems.org"

# Specify your gem's dependencies in sge.gemspec
gemspec

require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']

gem "guard", ">= 0.6.2"
gem "guard-bundler", ">= 0.1.3"
gem "guard-rspec", ">= 0.4.3"

case HOST_OS
  when /darwin/i
    gem 'rb-fsevent'
    gem 'growl'
    gem "ruby_gntp"
  when /linux/i
    gem 'libnotify'
    gem 'rb-inotify'
  when /mswin|windows/i
    gem 'rb-fchange'
    gem 'win32console'
    gem 'rb-notifu'
end

