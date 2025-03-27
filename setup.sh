#!/usr/bin/env bash

DIR=$HOME/dotfiles
pushd $DIR

echo "Initializing submodules"
git submodule update --init

# Copies to ~ if file doesnt exist, sources otherwise
install_file() {
  if [ -f ~/$1 ]; then
    echo $1 "exists, appending to it"
    echo "source ~/dotfiles/$file" >> ~/$file
  else
    echo "Installing $1"
    ln ~/dotfiles/$file ~/$file
  fi
}


echo "Creating dotfile links on ~/"

files=".bashrc .vimrc .gitignore .inputrc .gvimrc .tmux.conf .zshrc"

dirs=".vim"

for file in $files; do
  install_file $file
done

for dir in $dirs; do
      if [ -f ~/$dir ]; then
        echo $dir "exists. Ignoring."
      else
       echo "Installing "$dir
       ln -s ~/dotfiles/$dir ~/$dir
      fi
done

git config --global core.excludesfiles ~/.gitignore

echo "...done"
