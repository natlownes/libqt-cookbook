#
# Cookbook Name:: libqt-cookbook
# Recipe:: default
#
# Copyright 2012, Fort Hill Company
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
require_recipe 'apt'

packages = {}
packages[:ubuntu] = []
packages[:debian] = []

packages[:ubuntu] << value_for_platform(
  ['ubuntu'] => {['11.04', '11.10'] => 'libqtwebkit-dev'}
)

debian_and_ubuntu = value_for_platform(
  ['debian', 'ubuntu'] => {'default' => ['libqt4-dev', 'qt4-qmake']}
)

packages[:debian] << debian_and_ubuntu

packages[:ubuntu] << debian_and_ubuntu

packages.each do |key,value|
  packages[key] = value.compact.flatten
end

if node[:lsb][:codename] == 'lucid'
  apt_repository 'lucid-backports' do
    #uri "http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu" 
    uri "http://archive.ubuntu.com/ubuntu" 
    distribution 'lucid-backports'
    components %w(main)
  end

  packages[:ubuntu].each do |pkg_name|
    package pkg_name do
      options "--force-yes -t lucid-backports"
      action  :install
    end
  end
end

if node[:lsb][:codename] == 'squeeze'
  apt_repository 'squeeze-backports' do
    uri "http://backports.debian.org/debian-backports" 
    distribution 'squeeze-backports'
    components %w(main)
  end

  packages[:debian].each do |pkg_name|
    package pkg_name do
      options "--force-yes -t squeeze-backports"
      action  :install
    end
  end
end

to_install = packages[node[:platform].to_sym]

to_install.each do |pkg|
  package pkg do
    action :install
  end
end
