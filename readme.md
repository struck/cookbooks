Chef Cookbooks
=====================

To test a cookbook:

mkdir ~/cookbook_tests
cd ~/cookbook_tests
mkdir TEST_NAME
cd TEST_NAME
gem install vagrant
vagrant init

If a 3rd party cookbook is required but not downloaded to your machine, use
knife cookbook site vendor cookbook_name
command to load cookbooks from 3rd parties


