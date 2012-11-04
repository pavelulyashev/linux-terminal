$CONFIG_DIR=$HOME/.linux-configs/

$VIM_DIR=$HOME/.vim/
$VIMRC=$HOME/.vimrc

$ROOT=/root

# install git + clone .gitconfig
apt-get install git-core vim screen mc moc grc python-setuptools python-pip 
        
git clone git://github.com/pavelulyashev/linux-configs.git $CONFIG_DIR

# vim
rm -r $VIM_DIR
git clone git://github.com/pavelulyashev/vim.git $VIM_DIR
echo "source $HOME/.vim/local.vim" > $VIMRC

# mc
cp $CONFIG_DIR/mc_ini $HOME/.mc/ini
mkdir $ROOT/.mc
ln -s $HOME/.mc/ini $ROOT/.mc/ini

# moc
cp $CONFIG_DIR/moc_config $HOME/.moc/config

# screen
cp $CONFIG_DIR/.screenrc $HOME
ln -s $HOME/.screenrc $ROOT/.screenrc

# git
cp $CONFIG_DIR/.gitconfig $HOME
ln -s $HOME/.gitconfig $ROOT/.gitconfig

# aliases
cp $CONFIG_DIR/bash/* $HOME
for file in $(ls -a $HOME | grep .bash); do ln -s $HOME/$file $ROOT/$file; done

# install mysql + copy grc config

rm -rf $CONFIG_DIR
