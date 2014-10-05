#
# Cookbook Name:: pybrew
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{zlib-devel openssl-devel gcc-gfortran sqlite sqlite-devel ncurses ncurses-devel readline readline-devel patch bzip2-devel tk-devel}.each do |pkg|
    package pkg do
        action :install
    end
end

%w{blas blas-devel lapack lapack-devel atlas atlas-devel}.each do |pkg|
    package pkg do
        action :install
    end
end

%w{freetype freetype-devel libpng libpng-devel tkinter tk-devel gtk2-devel}.each do |pkg|
    package pkg do
        action :install
    end
end

git "/home/natsume/local/matplotlib" do
    repository "git://github.com/matplotlib/matplotlib.git"
    reference "master"
    action :checkout
    user "natsume"
    group "webdb"
end

bash "cfitsio" do
    user "root"
    code <<-EOC
        cd /usr/local/src
        if ! [ -e cfitsio ]; then
            wget ftp://heasarc.gsfc.nasa.gov/software/fitsio/c/cfitsio3280.tar.gz
            tar zxvf cfitsio3280.tar.gz
            cd cfitsio
            ./configure && make
            cp fitsio.h /usr/local/include
            cp longnam.h /usr/local/include
            cp libcfitsio.a /usr/lib
        fi
    EOC
end

bash "freetype" do
    user "root"
    code <<-EOC
        cd /usr/local/src
        if ! [ -e freetype-2.4.4 ]; then
            wget http://download.savannah.gnu.org/releases/freetype/freetype-2.4.4.tar.gz
            tar zxvf freetype-2.4.4.tar.gz
            cd freetype-2.4.4
            ./configure && make
            make install
        fi
    EOC
end

bash "pythonbrew" do
    user "natsume"
    group "webdb"
    cwd "/home/natsume"
    environment "HOME" => "/home/natsume"
    code <<-EOC
        if ! [ -e .pythonbrew ]; then
            curl -kL http://xrl.us/pythonbrewinstall | bash
            dpkg --purge mercurial
            source $HOME/.pythonbrew/etc/bashrc
            pythonbrew install 2.7.3
            pybrew venv create lab -p 2.7.3
            pybrew venv use lab -p 2.7.3
            easy_install -U setuptools
        fi
    EOC
end

bash "minuit" do
    user "natsume"
    group "webdb"
    cwd "/home/natsume"
    environment "HOME" => "/home/natsume"
    code <<-EOC
        export MINUIT=$HOME/local/minuit
        if ! [ -e $MINUIT/Minuit-1_7_9 ]; then
            mkdir -p $MINUIT
            cd $MINUIT
            wget http://pyminuit.googlecode.com/files/Minuit-1_7_9-patch1.tar.gz
            tar zxvf Minuit-1_7_9-patch1.tar.gz
            cd $MINUIT/Minuit-1_7_9
            ./configure --prefix=$MINUIT
            make
            make install
        fi
    EOC
end

bash "pip_package" do
    user "natsume"
    group "webdb"
    cwd "/home/natsume"
    environment "HOME" => "/home/natsume"
    code <<-EOC
        source $HOME/.pythonbrew/etc/bashrc
        pybrew venv use lab -p 2.7.3
        export SITE_PACKAGES=$HOME/.pythonbrew/venvs/Python-2.7.3/lab/lib/python2.7/site-packages
        if ! [ -e $SITE_PACKAGES/bpython ]; then
            pip install bpython
        fi
        if ! [ -e $SITE_PACKAGES/numpy ]; then
            pip install numpy
        fi
        if ! [ -e $SITE_PACKAGES/pyfits ]; then
            pip install pyfits
        fi
        if ! [ -e $SITE_PACKAGES/healpy ]; then
            pip install healpy
        fi
    EOC
end

bash "pyminuit" do
    user "natsume"
    group "webdb"
    cwd "/home/natsume"
    environment "HOME" => "/home/natsume"
    code <<-EOC
        export PYMINUIT=$HOME/local/pyminuit
        MINUIT=$HOME/local/minuit
        cd $HOME/local
        if ! [ -e $PYMINUIT ]; then
            wget http://pyminuit.googlecode.com/files/pyminuit-1.2.1.tgz
            tar zxvf pyminuit-1.2.1.tgz
        fi
        export SITE_PACKAGES=$HOME/.pythonbrew/venvs/Python-2.7.3/lab/lib/python2.7/site-packages
        if ! [ -e $SITE_PACKAGES/minuit.so ]; then
            cd $PYMINUIT
            source $HOME/.pythonbrew/etc/bashrc
            pybrew venv use lab -p 2.7.3
            python setup.py install --with-minuit=$MINUIT/Minuit-1_7_9
            echo "export MINUIT=\\$HOME/local/minuit" >> $HOME/.zshenv
            echo "export LD_LIBRARY_PATH=\\$LD_LIBRARY_PATH:\\$MINUIT/lib" >> $HOME/.zshenv
        fi
    EOC
end

bash "matplotlib" do
    user "natsume"
    group "webdb"
    cwd "/home/natsume"
    environment "HOME" => "/home/natsume"
    code <<-EOC
        export SITE_PACKAGES=$HOME/.pythonbrew/venvs/Python-2.7.3/lab/lib/python2.7/site-packages
        if ! [ -e $SITE_PACKAGES/matplotlib ]; then
            source $HOME/.pythonbrew/etc/bashrc
            pybrew venv use lab -p 2.7.3
            cd $HOME/local/matplotlib
            python setup.py install
        fi
    EOC
end
