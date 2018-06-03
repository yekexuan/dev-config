```sh
# 升级vim 8 安装git
sudo apt-get install git
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim

composer依赖

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

配置vim

安装plug 管理 （https://github.com/junegunn/vim-plug）
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

安装配置依赖  Youcompleteme
sudo apt-get install build-essential cmake
sudo apt-get install build-essential cmake3

sudo apt-get install python-dev python3-dev

cd /home/vagrant/.vim/plugged/YouCompleteMe && ./install.py --clang-completer

ubuntu 安装ack
sudo apt-get install ack-grep

安装gtags

sudo apt-get build-dep global
sudo apt-get install libncurses5-dev libncursesw5-dev

wget http://101.96.10.24/tamacom.com/global/global-6.6.2.tar.gz && tar xzvf global-6.6.2.tar.gz && cd global-6.6.2/
./configure --with-sqlite3   # gtags可以使用Sqlite3作为数据库, 在编译时需要加这个参数
make -j4
sudo make install

ctags
sudo apt-get install autoconf
sudo apt-get install -y pkg-config
git clone https://github.com/universal-ctags/ctags.git
./autogen.sh
./configure
make
```
