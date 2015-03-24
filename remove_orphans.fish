function remove_orphans -d 'Remove orphaned packages'
	sudo pacman -Rs (sudo pacman -Qqtd)
	return 0
end
