function ban -d 'Ban IP address using ufw'
	if set -q argv
		ufw insert 1 deny from $argv
	else
		echo An IP must be put as an argument.
	end
end
