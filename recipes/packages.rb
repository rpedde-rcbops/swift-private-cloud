#
# Cookbook Name:: swift-private-cloud
# Recipe:: packages
#
# Copyright 2012, Rackspace US, Inc.
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

case node["platform_family"]
when "rhel"

  include_recipe "yum::epel"

  yum_key "RPM-GPG-KEY-swift-extras" do
    url "http://download.opensuse.org/repositories/home:/rpcops:/grizzly/CentOS_CentOS-6/repodata/repomd.xml.key"
    action :add
  end

  yum_repository "swift-extras" do
    repo_name "swift-extras"
    key "RPM-GPG-KEY-swift-extras"
    url "http://download.opensuse.org/repositories/home:/rpcops:/grizzly/CentOS_CentOS-6/"
    type "rpm-md"
  end

when "debian"

  include_recipe "apt::default"

  template "/etc/apt/preferences" do
    source "common/etc/apt/preferences.erb"
  end

  apt_repository "dell" do
    uri "http://linux.dell.com/repo/community/deb/latest"
    distribution "/"
    key "1285491434D8786F"
    keyserver "hkps.pool.sks-keyservers.net"
  end

  apt_repository "megaraid" do
    uri "http://hwraid.le-vert.net/ubuntu"
    key "6005210E23B3D3B4"
    keyserver "hkps.pool.sks-keyservers.net"
    distribution node["lsb"]["codename"]
    components ["main"]
  end

  apt_repository "cloudarchive-proposed" do
    uri "http://ubuntu-cloud.archive.canonical.com/ubuntu"
    distribution "precise-proposed/grizzly"
    components ["main"]
    key "5EDB1B62EC4926EA"
    keyserver "hkps.pool.sks-keyservers.net"
  end

  apt_repository "cloudarchive-updates" do
    uri "http://ubuntu-cloud.archive.canonical.com/ubuntu"
    distribution "precise-updates/grizzly"
    components ["main"]
    key "5EDB1B62EC4926EA"
    keyserver "hkps.pool.sks-keyservers.net"
  end

  apt_repository "swift-extras" do
    uri "http://download.opensuse.org/repositories/home:/rpcops:/grizzly/xUbuntu_12.04"
    distribution "/"
    key "http://download.opensuse.org/repositories/home:/rpcops:/grizzly/xUbuntu_12.04/Release.key"
  end


end
