#!/usr/bin/env bash

#set -e #Exit on error
#set -v #Enable verbosity

#PROGRAMS=(alias bash env git python scripts tmux vim)
PROGRAMS=(bash git vim)
OLD_DOTFILES="dotfile_bk_$(date -u +"%Y%m%d%H%M%s")"
mkdir $OLD_DOTFILES

function backup_if_exists() {
	if [ -f $1 ]; then
		mv $1 $OLD_DOTFILES
	fi
	if [ -d $1 ]; then
		mv $1 $OLD_DOTFILES
	fi
}

#clean common conflicts
#backup_if_exists ~/.back_profile
backup_if_exists ~/.bashrc
backup_if_exists ~/.gitconfig
backup_if_exists ~/.vimrc

mkdir -p ~/.vim/undo-dir

for program in ${PROGRAMS[@]}; do
	stow -v --target=$HOME $program
	echo "Configuring $program"
done

echo "Done!"
