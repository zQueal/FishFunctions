function battery -d 'Show battery percentage and status'
	command upower -i (upower -e | grep 'BAT') | grep --color=never -E "state|to\ full|percentage"
end
