# Description

Installs packages required for running Amon server monitoring software.

Based on installation instructions at [http://amon.cx/guide/install/](http://amon.cx/guide/install/) and configuration instructions at [http://amon.cx/guide/configure/](http://amon.cx/guide/configure/).

Amon uses a config file on the server it is installed to at /etc/amon.conf. This cookbook will write a complete config file based on the settings specified in the node[:amon][:config] data. (See Attributes::Config)

Amon's daemons will be started automatically unless the node[:amon][:autostart] is set to false. (see Attributes)

# Requirements
###Platform

*Amon support tested for:*

- Ubuntu
- Debian
- CentOS
- Fedora
- Amazon Linux AMI
- Mac OS X

*Amon Cookbook support tested for:*

- Ubuntu 11.10

### Cookbook Dependencies


- mongodb
- tornado
- build-essential

*these cookbooks also have their own dependencies, such as python and pip*

# Attributes

**:version**

The version of Amon to install. Current latest version: 0.7.5

Available versions: 

* 0.7.5

**:install_method**

Defines the method with which to download and install amon. *:auto* (default) will install using the install.amon.cx installer script. *:manual* will download the tarball and run the setup step by step as described on [http://amon.cx/guide/install/](http://amon.cx/guide/install/).

**:autostart**

If true (default), the amon and amond daemons will be started automatically. If false, the daemons can still be started by running the recipe amon[:services].
*currently only available for :manual install mode.* If in :auto install mode, the downloaded installer script will start the services automatically. In auto installation mode, if :autostart is true, the services will be restarted after the new config file is written. Generally, autostart should be true when in auto mode, otherwise the services may continue to operate based on a config that is no longer represented by the /etc/amon.conf. A warning is provided when :auto install mode is set but :autostart is set to false.

*some autostart functionality still a work in progress*

###Config (/etc/amon.conf)

The node[:amon][:config] data is a direct representation of the config options specified on the [http://amon.cx/guide/configuration/](http://amon.cx/guide/configuration/) page. The config file is written to the node as /etc/amon.conf. 

These config settings all have default values as specified by the default amon.conf file at installation, but can be further defined using node data settings.

See cookbook file /attributes/default.rb for a list of available config options.

Usage
=====

