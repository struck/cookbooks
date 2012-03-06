#
# Cookbook Name:: amon
# Attributes:: default
#

default[:amon][:version] = "0.7.5"
default[:amon][:tmp_dir] = Chef::Config[:file_cache_path]
default[:amon][:user] = "amon"
default[:amon][:install_method] = :auto

# ** autostart is primarily a setting for :manual installation mode. 
# if in auto installation mode, the installer script will start the services. In auto installation mode, if :autostart is true, the services will be restarted after the new config file is written. Generally, autostart should be true when in auto mode, otherwise the services may continue to operate based on a config that is no longer represented by the /etc/amon.conf
default[:amon][:autostart] = true

# default[:amon][:port] = 27017

# Settings that will live in /etc/amon.conf
# See: http://amon.cx/guide/configuration/

# Require the mongodb attributes to be initialized before amon's.
include_attribute "mongodb"

# backend - Connection details for various Amon backends.
# mongo - Configuration options for the mongo backend
# port - The port used to connect to mongo.Default: 27017
default[:amon][:config][:backend][:mongo][:port] = node[:mongodb][:port].to_s
# host - The host where mongo is installed. Default: “127.0.0.1”
default[:amon][:config][:backend][:mongo][:host] = "127.0.0.1"

# web_app - Configuration options for the web interface
# host - The host where the web application is running. Default: “127.0.0.1”
default[:amon][:config][:web_app][:host] = "127.0.0.1"
# port - The port where the web application is running. Default: 2464
default[:amon][:config][:web_app][:port] = "2464"

# system_check_period - How often does the daemon collect information, in seconds. Default: 60
default[:amon][:config][:system_check_period] = 60
# process_checks - List with all the procesess you want to check on the server.
# Format: [‘mongo’,’apache’]
default[:amon][:config][:process_checks] = nil
# Amon checks the process information using the standart Unix tools. Before adding something to the list you can check the validity of your string with: ps aux | grep process

# acl - Turns on the authentication module.
default[:amon][:config][:acl] = "False"
# “True” - auth on. When you change the acl parameter to “True” for the first time, you will be redirected to “http://127.0.0.1:2464/create_user”, where you can create a user and then you will be able to log in.

# secret_key - Random string, generated everytime you install or update Amon. Used for cookies and sessions, when the authenication module is on.
default[:amon][:config][:secret_key] = ""
# This secret_key config should only be saved in the node[:amon][:config] if it must be precise for this node. When the amon.conf config file is written on the node, this secret_key will be retained if it was previously written to the node's amon.conf. A non blank value in default[:amon][:config][:secret_key], however, will override any value on the node's amon.conf.

# timezone - Amon saves and displays everything in UTC. With this option you can display the data in your local timezone. To do that, find your desired timezone at http://en.wikipedia.org/wiki/List_of_tz_database_time_zones and paste the value from the TZ row in amon.conf
default[:amon][:config][:timezone] = "America/Los_Angeles"
