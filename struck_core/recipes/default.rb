#
# Cookbook Name:: struck_core
# Recipe:: default
#
# Copyright 2012, Struck
#
# All rights reserved - Do Not Redistribute
#

tested_platforms = {
  :ubuntu => ["10.04", "11.10"]
}

# Kick you out if you're not using a system this recipe has been tested on.
platform = tested_platforms[node[:platform].to_sym]
def invalid_platform
  log "You may not proceed using an untested platform. Yours is: (#{node[:platform]}-#{node[:platform_version]})"
  raise "You may not proceed using an untested platform. Yours is: (#{node[:platform]}-#{node[:platform_version]})"
end
invalid_platform() unless platform && platform.include?(node[:platform_version].to_s)

# If this cookbook is running on a vagrant box, we'll want to override some attributes. 
# See recipes/vagrant for more information.
if node[:instance_role] == 'vagrant'
  puts "** \n\n"
  puts "Running this recipe on a Vagrant box. Some core attributes will be overridden."
  include_recipe 'struck_core::vagrant'
  puts "** \n"
end

# Essential package handlers
require_recipe "apt"
require_recipe "build-essential"
require_recipe "git"

# Struck Core
# Core server settings 
# require_recipe "struck_core::server"
# Core sysadmin users/groups
# require_recipe "struck_core::users"
# Core firewall. Always lock it down.
require_recipe "struck_core::firewall"

