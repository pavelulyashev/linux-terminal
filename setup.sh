CONFIG_DIR=$HOME/.linux-terminal/
VIM_DIR=$HOME/.vim/
VIMRC=$HOME/.vimrc
ROOT=/root

# install git + clone .gitconfig
echo -e "\e[1;32m--> Installing packages ...\e[0m"
sudo apt-get install git-core vim screen mc moc grc python-setuptools python-pip 

echo -e "\e[1;32m-----> Installing pygments ...\e[0m"
sudo easy_install Pygments
        
echo -e "\e[1;32m-------> Cloning general configs ...\e[0m"
rm -rf $CONFIG_DIR
git clone git://github.com/pavelulyashev/linux-terminal.git $CONFIG_DIR

# vim
echo -e "\e[1;32m---------> Configuring vim ...\e[0m"
rm -rf $VIM_DIR
git clone git://github.com/pavelulyashev/vim.git $VIM_DIR
echo "source $HOME/.vim/local.vim" > $VIMRC

# mc
echo -e "\e[1;32m-----------> Configuring mc ...\e[0m"
mkdir $HOME/.mc
cp $CONFIG_DIR/mc_ini $HOME/.mc/ini
sudo mkdir $ROOT/.mc
sudo ln -sf $HOME/.mc/ini $ROOT/.mc/ini

# moc
echo -e "\e[1;32m-------------> Configuring moc ...\e[0m"
mkdir $HOME/.moc
cp $CONFIG_DIR/moc_config $HOME/.moc/config

# screen
echo -e "\e[1;32m---------------> Configuring screen ...\e[0m"
cp $CONFIG_DIR/.screenrc $HOME
sudo ln -sf $HOME/.screenrc $ROOT/.screenrc

# git
echo -e "\e[1;32m-----------------> Configuring git ...\e[0m"
cp $CONFIG_DIR/.gitconfig $HOME
sudo ln -sf $HOME/.gitconfig $ROOT/.gitconfig

# aliases
echo -e "\e[1;32m-------------------> Configuring root bash ...\e[0m"
cp $CONFIG_DIR/bash/.bash* $HOME
for file in $(ls -a $CONFIG_DIR/bash | grep .bash); do sudo ln -sf $HOME/$file $ROOT/$file; done

# install mysql + copy grc config

echo -e "\e[1;32m---------------------> Removing temporary files ...\e[0m"
rm -rf $CONFIG_DIR

echo -e "\e[1;32m-----------------------> Done\e[0m"

