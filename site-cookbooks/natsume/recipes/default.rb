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

user "natsume" do
    comment "natsume"
    home "/home/natsume"
    shell "/bin/zsh"
    password '1YznKMMJ2.iVg'
    supports :manage_home => true
    action [:create, :manage, :modify]
end

group "webdb" do
    action [:create, :modify]
    members ['natsume']
    append true
end

git "/home/natsume/dotfiles" do
    repository "git://github.com/kota999/dotfiles.git"
    reference "master"
    action :sync
    user "natsume"
    group "webdb"
end


bash "set_rc" do
    user "natsume"
    group "webdb"
    cwd "/home/natsume"
    environment "HOME" => "/home/natsume"
    code <<-EOC
        cp dotfiles/zshrc .zshrc
        cp dotfiles/vim/mylinux/vimrc .vimrc
    EOC
end
