#
# Cookbook Name:: scipy
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
git "/home/testname/local/scipy" do
    repository "git://github.com/scipy/scipy.git"
    reference "master"
    action :checkout
    user "testname"
    group "test"
end

bash "scipy" do
    user "testname"
    group "test"
    cwd "/home/testname"
    environment "HOME" => "/home/testname"
    code <<-EOC
        export SITE_PACKAGES=$HOME/.pythonbrew/venvs/Python-2.7.3/lab/lib/python2.7/site-packages
        if ! [ -e $SITE_PACKAGES/Cython ]; then
            source $HOME/.pythonbrew/etc/bashrc
            pybrew venv use lab -p 2.7.3
            pip install cython
        fi
        if ! [ -e $SITE_PACKAGES/scipy ]; then
            source $HOME/.pythonbrew/etc/bashrc
            pybrew venv use lab -p 2.7.3
            cd $HOME/local/scipy
            python setup.py install
        fi
    EOC
end
