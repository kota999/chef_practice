#
# Cookbook Name:: yum_repo
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
yum_repository 'epel' do
    description 'Extra Packages for Enterprise Linux'
    mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch'
    fastestmirror_enabled true
    gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
    action :create
end


yum_repository 'remi' do
    description 'Les RPM de Remi - Repository'
    baseurl 'http://rpms.famillecollet.com/enterprise/6/remi/x86_64/'
    gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
    fastestmirror_enabled true
    action :create
end


yum_repository 'rpmforge' do
    mirrorlist 'http://mirrorlist.repoforge.org/el6/mirrors-rpmforge'
    description 'RHEL $releasever - RPMforge.net - dag'
    enabled true
    gpgcheck true
    gpgkey 'http://apt.sw.be/RPM-GPG-KEY.dag.txt'
end
