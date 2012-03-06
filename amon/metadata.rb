maintainer        "Struck"
maintainer_email  "nerds@struck.com"
description       "Installs amon and amond"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.0"
recipe            "build-essential", "Installs C compiler and build tools on Linux"

depends           "build-essential"
depends           "mongodb" # Mongo db for debian boxes
depends           "python"
depends           "tornado"

# www.amon.cx
# More installation instruction at http://amon.cx/guide/install/

# TODO: test on each of these boxes before declaring support.
# fedora redhat centos debian

%w{ ubuntu debian }.each do |os|
  supports os
end



