#! /usr/bin/env bash

CONFIG_DIR=$HOME/.linux-terminal/
VIM_DIR=$HOME/.vim/
VIMRC=$HOME/.vimrc
ROOT=/root


progress=1

function echo_progress {
    printf "$progress. \e[1;33m%.0s---> \e$1\n"
    (( progress = $progress + 1 ))
}


# install git + clone .gitconfig
echo_progress "Installing packages ..."
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


echo_progress "Installing pygments ..."
sudo easy_install Pygments
        
echo_progress "Cloning general configs ..."
rm -rf $CONFIG_DIR
git clone git://github.com/pavelulyashev/linux-terminal.git $CONFIG_DIR

# vim
echo_progress "Configuring vim ..."
sudo chown -R $USER $HOME/.vim/
rm -rf $VIM_DIR
git clone git://github.com/pavelulyashev/vim.git $VIM_DIR
echo_progress "source $HOME/.vim/rc.vim" > $VIMRC
sudo chown -R $USER $HOME/.vim/
cd $VIM_DIR
git submodule init && git submodule update

# mc
echo_progress "Configuring mc ..."
if [ -d $HOME/.mc ]; then
    cp $CONFIG_DIR/mc_ini $HOME/.mc/ini
elif [ -d $HOME/.config/mc ]; then
    cp $CONFIG_DIR/mc_ini $HOME/.config/mc/ini
fi
sudo mkdir $ROOT/.mc
sudo ln -sf $HOME/.mc/ini $ROOT/.mc/ini

# moc
echo_progress "Configuring moc ..."
mkdir $HOME/.moc
cp $CONFIG_DIR/moc_config $HOME/.moc/config
chmod 644 $HOME/.moc/config

# screen
echo_progress "Configuring screen ..."
cp $CONFIG_DIR/.screenrc $HOME
sudo ln -sf $HOME/.screenrc $ROOT/.screenrc

# git
echo_progress "Configuring git ..."
cp $CONFIG_DIR/.gitconfig $HOME
sudo ln -sf $HOME/.gitconfig $ROOT/.gitconfig

# aliases
echo_progress "Configuring root bash ..."
cp $CONFIG_DIR/bash/.bash* $HOME
for file in $(ls -a $CONFIG_DIR/bash | grep .bash); do sudo ln -sf $HOME/$file $ROOT/$file; done

# install mysql + copy grc config

echo_progress "Removing temporary files ..."
rm -rf $CONFIG_DIR

echo_progress "Done"

