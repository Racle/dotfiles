stow:
	sudo rm -rf ~/.zshrc
	stow default zsh albert tmux neovim ranger kitty

stow-server:
	stow default zsh-server albert tmux neovim ranger

rm:
	rm ~/.zshrc ~/.p10k.zsh ~/.tmux.conf ~/.docker_aliases ~/.config/albert/albert.conf ~/.config/nvim/init.vim ~/.config/ranger/rc.conf ~/.config/kitty/kitty.conf
	echo "this might delete files from this repository also"

link-root:
	sudo rm -rf /root/.oh-my-zsh /root/.zshrc /root/.p10k.zsh /root/.docker_aliases
	sudo ln -s ${HOME}/.oh-my-zsh /root/
	sudo ln -s ${HOME}/.zshrc /root/
	sudo ln -s ${HOME}/.p10k.zsh /root/
	sudo ln -s ${HOME}/.docker_aliases /root/
