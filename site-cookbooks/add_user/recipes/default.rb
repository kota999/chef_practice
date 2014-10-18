#
# Cookbook Name:: natsume
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#data_ids = data_bag('users')
#data_ids.each do |id|
    #u = data_bag_item('users', id)
    #user u['username'] do
        #home u['home']
        #shell u['shell']
    #end
#end

user "testname" do
    comment "testname"
    home "/home/testname"
    shell "/bin/zsh"
    password 'YOUR_PASS'
    supports :manage_home => true
    action [:create, :manage, :modify]
end

group "test" do
    action [:create, :modify]
    members ['testname']
    append true
end

git "/home/testname/dotfiles" do
    repository "git://github.com/kota999/dotfiles.git"
    reference "master"
    action :sync
    user "testname"
    group "test"
end


bash "set_rc" do
    user "testname"
    group "test"
    cwd "/home/testname"
    environment "HOME" => "/home/testname"
    code <<-EOC
        cp dotfiles/zshrc .zshrc
        cp dotfiles/vim/mylinux/vimrc .vimrc
        if ! [ -e local ]; then
            mkdir local
        fi
    EOC
end
