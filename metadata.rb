maintainer       "Fort Hill Company"
maintainer_email "dev@forthillcompany.com"
license          "Apache 2.0"
description      "Installs/Configures libqt-cookbook"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
supports         %w(debian ubuntu)

requirements = %w(apt)

requirements.each do |r|
  depends r
end

