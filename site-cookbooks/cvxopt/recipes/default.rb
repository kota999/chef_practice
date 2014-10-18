#
# Cookbook Name:: cvxopt
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash "cvxopt" do
    user "testname"
    group "test"
    cwd "/home/testname"
    environment "HOME" => "/home/testname"
    code <<-EOC
        cd $HOME/local
        if ! [ -e cvxopt-1.1.5 ]; then
            wget http://abel.ee.ucla.edu/src/cvxopt-1.1.5.tar.gz
            tar zxvf cvxopt-1.1.5.tar.gz
            cd cvxopt-1.1.5/src
            cp setup.py setup.py.old
            export BEFORE="/usr/lib"
            export AFTER="/usr/lib64/atlas"
            sed -i -e "5s|$BEFORE|$AFTER|" cvxopt-1.1.5/src/setup.py
            export BEFORE="'blas'"
            export AFTER="'ptf77blas', 'ptcblas', 'atlas', 'gfortran', 'gomp'"
            sed -i -e "8s|$BEFORE|$AFTER|" cvxopt-1.1.5/src/setup.py
            source $HOME/.pythonbrew/etc/bashrc
            pybrew venv use lab -p 2.7.3
            python setup.py install
        fi
    EOC
end
