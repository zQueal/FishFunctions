function read_confirm --description 'Asks for confirmation of an action'
  while true
    read -g -p read_prompt confirm
    switch $confirm
      case Y y
        return 0
      case '' N n
	echo Exception. Exiting...
        return 1
    end
  end
end

function read_prompt
  echo "Really continue? [Y/n] "
end
