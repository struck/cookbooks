Description
===========
Installs and configures Tornado web server.
http://www.tornadoweb.org/

_This is yet a mostly untested cookbook, having left out most all distributions and previous versions of Tornado. It should be considered beta software._

Requirements
============
Platform
--------

* Ubuntu
* yet untested on remaining linux distros

Cookbooks
---------

* python

Attributes
==========

:version
--------
The version of Tornado to install. Current latest version: 2.2

:install_method
---------------
Defines the method with which to download and install tornado. :pip (default) will install using the python package manager. :tarball will download the tarball and run setup.py build and install.

Additional attributes, less important:
--------------------------------------
* :tmp_dir
* :user

Usage
=====

