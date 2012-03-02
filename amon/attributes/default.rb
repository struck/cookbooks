#
# Cookbook Name:: amon
# Attributes:: default
#

default[:amon][:version] = "0.7.5"
default[:amon][:tmp_dir] = "/tmp"
default[:amon][:user] = "amon"

# default[:amon][:port] = 27017

# Settings that will live in /etc/amon.conf
# See: http://amon.cx/guide/configuration/

# backend - Connection details for various Amon backends.
# mongo - Configuration options for the mongo backend
# port - The port used to connect to mongo.Default: 27017
default[:amon][:config][:backend][:mongo][:port] = node[:mongodb][:port]
# host - The host where mongo is installed. Default: “127.0.0.1”
default[:amon][:config][:backend][:mongo][:host] = node[:mongodb][:host]

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

# secret_key - Random string, generated everytime you install or update Amon. Used for cookies and sessions, when the authenicaion module is on.
default[:amon][:config][:secret_key] = ""

# timezone - Amon saves and displays everything in UTC. With this option you can display the data in your local timezone. To do that, find your desired timezone at http://en.wikipedia.org/wiki/List_of_tz_database_time_zones and paste the value from the TZ row in amon.conf
default[:amon][:config][:timezone] = "America/Los_Angeles"
