#
# Cookbook Name:: mpi4py
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "openmpi" do
    action :install
end

package "openmpi-devel" do
    action :install
end

bash "mpi4py" do
    user "natsume"
    group "webdb"
    cwd "/home/natsume"
    environment "HOME" => "/home/natsume"
    code <<-EOC
        source $HOME/.pythonbrew/etc/bashrc
        pybrew venv use lab -p 2.7.3
        export SITE_PACKAGES=$HOME/.pythonbrew/venvs/Python-2.7.3/lab/lib/python2.7/site-packages
        if ! [ -e $SITE_PACKAGES/mpi4py ]; then
            echo "export OPENMPI=/usr/lib64/openmpi" >> $HOME/.zshenv
            source $HOME/.zshenv
            echo "export PATH=\\$PATH:\\$OPENMPI/bin" >> $HOME/.zshenv
            echo "export LD_LIBRARY_PATH=\\$LD_LIBRARY_PATH:\\$OPENMPI/lib" >> $HOME/.zshenv
            source $HOME/.zshenv
            pip install mpi4py
        fi
    EOC
end
