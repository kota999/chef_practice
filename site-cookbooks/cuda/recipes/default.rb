#
# Cookbook Name:: cuda
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
package "cuda" do
    action :install
end

git "/home/testname/local" do
    repository "git://github.com/lebedov/scikits.cuda.git"
    reference "master"
    action :checkout
    user "testname"
    group "test"
end

bash "pycuda" do
    user "testname"
    group "test"
    cwd "/home/testname"
    environment "HOME" => "/home/testname"
    code <<-EOC
        source $HOME/.pythonbrew/etc/bashrc
        pybrew venv use lab -p 2.7.3
        export SITE_PACKAGES=$HOME/.pythonbrew/venvs/Python-2.7.3/lab/lib/python2.7/site-packages
        if ! [ -e $SITE_PACKAGES/pycuda ]; then
            pip install pycuda
            cd $HOME/local/scikits.cuda
            python setup.py install
        fi
    EOC
end
