
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

files=".bashrc .vimrc .gitignore .inputrc"
extras="tmux.conf"

dirs=".vim .git"

for file in $files; do
  install_file $file
done

for file in $extras; do
  read -p "Want to install $file? (y/n)" answer
  if [[ $answer == "y" || $answer == "Y" ]]
    then
    intall_file $file
  fi
done

for dir in $dirs; do
      if [ -f ~/$dir ]; then
        echo $dir "exists. Ignoring."
      else
       echo "Installing "$dir
       ln -s ~/dotfiles/$dir ~/$dir
      fi
done

echo "...done"
