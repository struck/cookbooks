#
# Cookbook Name:: amon
# Recipe:: default
#
# Copyright 2012 Struck
#

require_recipe 'build-essential'
require_recipe 'mongodb'
require_recipe 'tornado'

# Creates the user that will own the amon files and run the services.
user node[:amon][:user] do
  shell "/bin/bash"
  action :create
end

# Install amon using the specified method. 
log("Invalid install method"){ level :fatal } unless [:auto, :manual].include?(node[:amon][:install_method])
include_recipe "amon::#{node[:amon][:install_method]}"
# Apply the config settings based on node[:amon][:config]
require_recipe 'amon::config'

# Services
if node[:amon][:autostart]
  require_recipe 'amon::services' 
else
  if node[:amon][:install_method] == :auto
    # Autostart should be true when using auto install mode. See /README.md for more info.
    log("Autostart should be true when using auto install mode. See Amon Cookbook README for more info.") { level :warn }
  end
end


