function remove_orphans
	sudo pacman -Rs (sudo pacman -Qqtd)
return 0
end
