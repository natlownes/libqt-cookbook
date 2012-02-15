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
packages = {}
packages[:ubuntu] = []
packages[:debian] = []

packages[:ubuntu] << value_for_platform(
  ['ubuntu'] => {['11.04', '11.10'] => 'libqtwebkit-dev'}
)

debian_and_ubuntu = value_for_platform(
  ['debian', 'ubuntu'] => {'default' => 'libqt4-dev'}
)

packages[:debian] << debian_and_ubuntu

packages[:ubuntu] << debian_and_ubuntu

to_install = packages[node[:platform]]

to_install.each do |pkg|
  package pkg do
    action :install
  end
end
