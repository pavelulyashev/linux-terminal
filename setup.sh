#! /usr/bin/env bash

CONFIG_DIR=$HOME/.linux-terminal
VIM_DIR=$HOME/.vim/
VIMRC=$HOME/.vimrc


if [ $TERM_PROGRAM == "Apple_Terminal" ]; then
    is_mac=1 
else 
    is_mac=0 
fi


progress=1

function echo_progress {
    printf "\e[1;36m$progress. %.0s---> \e[1;32m$1\e[0m\n"
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
elif [[ $is_mac ]]; then 
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
cp $CONFIG_DIR/bash/.bash* $HOME

# vim
echo_progress "Configuring vim ..."
sudo chown -R $USER $HOME/.vim/
rm -rf $VIM_DIR
git clone git://github.com/pavelulyashev/vim.git $VIM_DIR
echo "source $HOME/.vim/rc.vim" > $VIMRC
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

# moc
if [ -f /usr/bin/mocp ]; then
    echo_progress "Configuring moc ..."
    [ ! -d $HOME/.moc ] && mkdir $HOME/.moc
    cp $CONFIG_DIR/moc_config $HOME/.moc/config
    chmod 644 $HOME/.moc/config
fi

# screen
echo_progress "Configuring screen ..."
cp $CONFIG_DIR/.screenrc $HOME

# git
echo_progress "Configuring git ..."
cp $CONFIG_DIR/.gitconfig $HOME

# aliases
echo_progress "Configuring root bash ..."
if [[ ! $is_mac ]]; then
    ROOT=/root

    sudo ln -sf $HOME/.gitconfig $ROOT/.gitconfig
    sudo ln -sf $HOME/.screenrc $ROOT/.screenrc

    for file in $(ls -a $CONFIG_DIR/bash | grep .bash); do sudo ln -sf $HOME/$file $ROOT/$file; done

    sudo mkdir $ROOT/.mc
    sudo ln -sf $HOME/.mc/ini $ROOT/.mc/ini
fi

# install mysql + copy grc config

echo_progress "Removing temporary files ..."
rm -rf $CONFIG_DIR

echo_progress "Done"

