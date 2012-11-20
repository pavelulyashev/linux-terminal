CONFIG_DIR=$HOME/.linux-terminal/
VIM_DIR=$HOME/.vim/
VIMRC=$HOME/.vimrc
ROOT=/root

# install git + clone .gitconfig
echo `printf "\e[1;32m--> Installing packages ...\e[0m"`
if [ -e /usr/bin/apt-get ]; then
    sudo apt-get install git-core vim screen mc moc grc htop python-setuptools python-pip 
elif [ -e /usr/bin/yum ]; then
    sudo yum install -y git-core vim screen mc python-setuptools 
    sudo yum install http://pkgs.repoforge.org/htop/htop-1.0.1-2.el6.rf.x86_64.rpm
    sudo easy_install pip
    sudo pip install grc
elif [ $TERM_PROGRAM == "Apple_Terminal" ]; then 
    ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
    brew install git bash-completion vim mc htop
    brew install python --universal
    sudo easy_install pip
    sudo pip install grc
fi


echo `printf "\e[1;32m-----> Installing pygments ...\e[0m"`
sudo easy_install Pygments
        
echo `printf "\e[1;32m-------> Cloning general configs ...\e[0m"`
rm -rf $CONFIG_DIR
git clone git://github.com/pavelulyashev/linux-terminal.git $CONFIG_DIR

# vim
echo `printf "\e[1;32m---------> Configuring vim ...\e[0m"`
sudo chown -R $USER $HOME/.vim/
rm -rf $VIM_DIR
git clone git://github.com/pavelulyashev/vim.git $VIM_DIR
echo "source $HOME/.vim/local.vim" > $VIMRC
sudo chown -R $USER $HOME/.vim/

# mc
echo `printf "\e[1;32m-----------> Configuring mc ...\e[0m"`
if [ -d $HOME/.mc ]; then
    cp $CONFIG_DIR/mc_ini $HOME/.mc/ini
elif [ -d $HOME/.config/mc ]; then
    cp $CONFIG_DIR/mc_ini $HOME/.config/mc/ini
fi
sudo mkdir $ROOT/.mc
sudo ln -sf $HOME/.mc/ini $ROOT/.mc/ini

# moc
echo `printf "\e[1;32m-------------> Configuring moc ...\e[0m"`
mkdir $HOME/.moc
cp $CONFIG_DIR/moc_config $HOME/.moc/config
chmod 644 $HOME/.moc/config

# screen
echo `printf "\e[1;32m---------------> Configuring screen ...\e[0m"`
cp $CONFIG_DIR/.screenrc $HOME
sudo ln -sf $HOME/.screenrc $ROOT/.screenrc

# git
echo `printf "\e[1;32m-----------------> Configuring git ...\e[0m"`
cp $CONFIG_DIR/.gitconfig $HOME
sudo ln -sf $HOME/.gitconfig $ROOT/.gitconfig

# aliases
echo `printf "\e[1;32m-------------------> Configuring root bash ...\e[0m"`
cp $CONFIG_DIR/bash/.bash* $HOME
for file in $(ls -a $CONFIG_DIR/bash | grep .bash); do sudo ln -sf $HOME/$file $ROOT/$file; done

# install mysql + copy grc config

echo `printf "\e[1;32m---------------------> Removing temporary files ...\e[0m"`
rm -rf $CONFIG_DIR

echo `printf "\e[1;32m-----------------------> Done\e[0m"`

