#
# Cookbook Name:: amon
# Recipe:: default
#
# Copyright 2012 Struck
#

require_recipe 'build-essential'
require_recipe 'mongodb'
require_recipe 'tornado'

packages = ['curl']
rpm_linux = platform?("redhat", "centos", "fedora")
deb_linux = platform?("ubuntu", "debian")

packages += ["gcc", "python-dev", "sysstat"] if deb_linux
packages += ["gcc", "python-devel", "sysstat"] if rpm_linux

packages.each do |pkg|
  package pkg
end

# Creates the user that will own the amon files and run the services.
user node[:amon][:user] do
  shell "/bin/bash"
  action :create
end

# Apply the config settings based on node[:amon][:config]
# require_recipe 'amon::config'
# Install amon using the specified method. 
log("Invalid install method"){ level :fatal } unless [:auto, :manual].include?(node[:amon][:install_method])
include_recipe "amon::#{node[:amon][:install_method]}"

