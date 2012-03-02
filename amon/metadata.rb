maintainer        "Struck"
maintainer_email  "nerds@struck.com"
description       "Installs amon and amond"
version           "1.0.0"
recipe            "build-essential", "Installs C compiler and build tools on Linux"

depends           "build-essential"
depends           "mongodb-debs" # Mongo db for debian boxes

# www.amon.cx
# More installation instruction at http://amon.cx/guide/install/

# TODO: test on each of these boxes before declaring support.
# fedora redhat centos debian

%w{ ubuntu debian }.each do |os|
  supports os
end



