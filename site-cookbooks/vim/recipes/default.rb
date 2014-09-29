#
# Cookbook Name:: vim
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "vim" do
    action :install
end

package "python" do
    action :install
end

package "python-devel" do
    action :install
end

package "python-setuptools" do
    action :install
end

package "ncurses-devel" do
    action :install
end

package "perl-ExtUtils-Embed" do
    action :install
end

package "mercurial" do
    action :install
end

package "lua" do
    action :install
end

package "lua-devel" do
    action :install
end

bash "compile_vim" do
    user "vagrant"
    group "vagrant"
    #cwd "/home/natsume"
    #environment "HOME" => "/home/natsume"
    code <<-EOC
        cd /usr/local/src
        if ! [ -e ./vim ]; then
            sudo hg clone https://vim.googlecode.com/hg/ vim
            cd vim
            sudo hg update
            sudo ./configure --enable-multibyte --with-features=huge --disable-selinux --prefix=/usr/local --enable-luainterp=yes --with-lua-prefix=/usr
            sudo make && sudo make install
        fi
    EOC
end

package "ctags" do
    action :install
end
