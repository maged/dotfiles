echo "Creating dotfile links on ~/"

files=".bashrc .vimrc tmux.conf .gitignore .gitmodules .inputrc"

dirs=".vim .git"

for file in $files; do
	ln ~/dotfiles/$file ~/$file
done

for dir in $dirs; do
    ln -s ~/dotfiles/$dir ~/$dir
done

echo "...done"
