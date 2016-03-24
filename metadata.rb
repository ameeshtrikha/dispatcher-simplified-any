maintainer        "Ameesh Trikha"
maintainer_email  "ameesh.trikha@gmail.com"
license           "Apache 2.0"
description       "Installs and configures the AEM's Dispatcher module, along with Apache 2"
version           "1.0.0"
name              "dispatcher-simplified-any"

%w{redhat centos scientific fedora debian ubuntu arch freebsd amazon}.each do |os|
  supports os
end

depends "apache2", ">= 2.4.0"