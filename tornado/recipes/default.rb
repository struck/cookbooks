#
# Cookbook Name:: tornado
# Recipe:: default
#
# Copyright 2012, Struck
#
# All rights reserved - Do Not Redistribute
#

# Installation instructions found at http://www.tornadoweb.org/

# 
# 
rpm_linux = platform?("redhat", "centos", "fedora")
deb_linux = platform?("ubuntu", "debian")
pv = node[:python][:version].to_f
# 
# 

# Creates the user that will own the tornado files and run the services.
user node[:tornado][:user] do
  shell "/bin/bash"
  action :create
end

# install prerequisite python packages
if pv >= 2.5 && pv <= 2.7
  package 'python-pycurl' do
    action :install
  end
end
if pv >= 3
  python_pip 'distribute' do
    action :install
  end
end

# Load the installer recipe based on install_method attribute.
case node[:tornado][:install_method]
when :tarball 
  # The tarball and checksum to download.
  tarball = "tornado-#{node[:tornado][:version]}.tar.gz"
  tarball_checksum = case node[:tornado][:version].to_s
  when "2.2" then "246f9c7cd476fc17a09c86cbcbab2350353dc0c6d9220e1acc8814186a1a0466"
  end
  
  # Download the tarball
  # Checksum will allow us to skip download if its already been downloaded.
  # tornado user will own the files
  remote_file File.join(node[:tornado][:tmp_dir], tarball) do
    source "http://github.com/downloads/facebook/tornado/#{tarball}"
    owner node[:tornado][:user]
    # SHA-256 checksum
    checksum "#{tarball_checksum}"
  end
  
  # Unzip the tarball into the /tmp/tornado directory
  # Overwrite any existing dir called 'tornado'
  # tornado user will own the files
  execute "tar zxf #{tarball} tornado --overwrite" do
    cwd node[:tornado][:tmp_dir]
    user node[:tornado][:user]
  end
  
  # Install some prequisite packages - gcc and python-dev, on RPM based distributions, the package is called python-devel
  pkgs = rpm_linux ? ['python-devel'] : ['gcc', 'python-dev']
  pkgs.each { |pkg| package pkg }
  
  # Run the setup.py build command using python
  execute "python ./setup.py build" do
    cwd File.join(node[:tornado][:tmp_dir], 'tornado')
    user node[:tornado][:user]
  end
  
  # Run the setup.py install command using python
  execute "python ./setup.py install" do
    cwd File.join(node[:tornado][:tmp_dir], 'tornado')
    user 'root'
  end
  
else 
  # Install using pip
  python_pip 'tornado' do
    version node[:tornado][:version]
    action :install
  end
end 

