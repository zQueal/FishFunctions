function options
  echo $argv | sed 's|--*|\\'\n'|g' | grep -v '^$'
end

function fhelp
  set -l green (set_color green)
  set -l yellow (set_color yellow)
  set -l blue (set_color blue)
  set -l normal (set_color normal)
  echo 'Usage: '$green'vhost'$yellow' [options] '$blue'DOMAIN'$normal
  echo $yellow'    -h, --help    '$normal'- List this help menu'
  echo $yellow'    -a, --about   '$normal'- About this script'
  echo $yellow'    -l, --list    '$normal'- List sites-enabled and sites-available'
  echo $yellow'    -e, --enable  '$normal'- Enables a disabled confiration'
  echo $yellow'    -d, --disable '$normal'- Removes given system link from sites-enabled'
  echo $yellow'    -c, --create  '$normal'- Creates default configuration files'
  echo $yellow'    -s, --skel    '$normal'- Creates configuration files based off of another configuration'
  echo $yellow'    -rm, --remove '$normal'- Removes given configuration from sites-enabled & sites-available'\n
  echo 'Examples:'
  echo $green'    vhost '$yellow'-c '$blue'example.com '$normal'# Creates example.com'
  echo $green'    vhost '$yellow'-d '$blue'example.com '$normal'# Disables example.com'
  echo $green'    vhost '$yellow'-e '$blue'example.com '$normal'# Enables example.com'
  echo $green'    vhost '$yellow'-s /var/skel/nginx.conf '$blue'example.com '$normal'# Creates example.com using nginx.conf as a template'
  echo $green'    vhost '$yellow'-rm '$blue'example.com '$normal'# Removes example.com'\n
end

function fabout
  echo 'I got tired of doing this manually. At the time of creating this I was learning about the fish shell. Don\'t judge me.'\n
  echo 'Name: Zach Queal'
  echo 'Email: zach.queal@gmail.com'
  echo 'Github: https://github.com/zQueal'\n
end

function vhost
  for i in (options $argv)
    echo $i | read -l option value
    switch $option
      case h help
	fhelp
      case l list
	echo 'Available Sites: '
	echo (ls /etc/nginx/sites-available/)
	echo \n'Enabled Sites: '
	echo (ls /etc/nginx/sites-enabled/)
      case rm remove
	echo Removing $value...
	if read_confirm
	  # for i in $value[$i]; echo (count $i); end
	  echo (count $value) # returns 1 reguardless of argv given
        end
      case c create
	echo 'create'\n
      case a about
	fabout
    end
  end 
end
