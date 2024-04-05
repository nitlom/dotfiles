#!/bin/bash

set -e
result=${PWD}          # to assign to a variable

FILES=(
	"~/.config/Code/User/settings.json" 
	"~/.vimrc" 
	"~/.zshrc")

for file in ${FILES[*]};
do
if [ -f $file ]; then
	#echo $file, $file"_dotfiles"
	mv $file $file"_beforedotfiles"
fi
done

ln -s ${PWD}/vscode/settings.json ~/.config/Code/User/settings.json
ln -s ${PWD}/.zshrc ~/.zshrc
ln -s ${PWD}/.vimrc ~/.vimrc

