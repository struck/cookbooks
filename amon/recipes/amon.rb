# 
# 
rpm_linux = platform?("redhat", "centos", "fedora")
deb_linux = platform?("ubuntu", "debian")
# 
# 

package 'curl'

# Following the Manual Installation instructions on 
# http://amon.cx/guide/install/

# The tarball and checksum to download.
tarball = "amon-#{node[:amon][:version]}.tar.gz"
tarball_checksum = "6203fcacf3cbe6e05f3732ed44b4061285f34577c8e5dc527baf6b21787b6688"

# 1. Download Amon from http://install.amon.cx/amon-0.7.5.tar.gz and install the package with sudo python setup.py install

# Download the tarball
# Checksum will allow us to skip download if its already been downloaded.
# amon user will own the files
remote_file File.join(node[:amon][:tmp_dir], tarball) do
  source "http://install.amon.cx/#{tarball}"
  owner node[:amon][:user]
  # SHA-256 checksum
  checksum "#{tarball_checksum}"
end

# Unzip the tarball into the /tmp/amon directory
# Overwrite any existing dir called 'amon'
# amon user will own the files
execute "tar zxf #{tarball} amon --overwrite" do
  cwd node[:amon][:tmp_dir]
  user node[:amon][:user]
end

# Run the setup.py command using python
# run as root, to install py packages
execute "python /tmp/amon/setup.py install" do
  cwd File.join(node[:amon][:tmp_dir], 'amon')
  # user node[:amon][:user]
  user 'root'
end

# 2. Install the prequisite packages - gcc and python-dev, on RPM based distributions, the package is called python-devel
pkgs = rpm_linux ? ['python-devel'] : ['gcc', 'python-dev']
pkgs.each { |pkg| package pkg }

# 3. Copy the configuration file from http://config.amon.cx/amon.conf to /etc/amon.conf
remote_file "/etc/amon.conf" do 
  source "http://config.amon.cx/amon.conf";
  owner node[:amon][:user]
  # SHA-256 checksum
  checksum "05326804ac1d129062ca501efbb43ba6752a84f00135aa85abb2e64f372e7a90"
end

# 4. Copy the system info collect daemon from http://config.amon.cx/amond to /etc/init.d/amond
remote_file "/etc/init.d/amond" do 
  source "http://config.amon.cx/amond";
  owner 'root'
  # SHA-256 checksum
  checksum "75d9a97e183e262807f88a4fac481a6c4cb0fa3638e8c90a43d41140fad4fab1"
end

# 5. Copy the web application daemon from http://config.amon.cx/amon to /etc/init.d/amon
remote_file "/etc/init.d/amon" do 
  source "http://config.amon.cx/amon";
  owner 'root'
  # SHA-256 checksum
  checksum "2911550b467b454387a363b389e3ed4b565af55539f82b8aedf04a222192ef80"
end

# 6. Make the daemons executable with sudo chmod +x /etc/init.d/amond /etc/init.d/amon
execute "chmod +x /etc/init.d/amond /etc/init.d/amon" do
  user 'root'
end

# 7. Create a directory for Amon specific log files sudo mkdir /usr/local/amon
directory "/usr/local/amon" do 
  owner node[:amon][:user]
end

# Config. We override what was written to the amon.conf file based on the config that now lives
# in our cookbook.
require 'json'
file "Set custom config" do
  path = "/etc/amon.conf"
  content = node[:amon][:config].to_json
  owner node[:amon][:user]
end

