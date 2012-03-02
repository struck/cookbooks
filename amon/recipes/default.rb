#
# Cookbook Name:: amon
# Recipe:: default
#
# Copyright 2012 Struck
#

require_recipe 'build-essential'
require_recipe 'mongodb-debs'

# Creates the user that will own the amon files and run the services.
user node[:amon][:user] do
  shell "/bin/bash"
  action :create
end

require_recipe 'amon::amon'
require_recipe 'amon::services'

