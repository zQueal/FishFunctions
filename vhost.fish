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
  echo 'I got tired of doing this manually. At the time of creating this I was learning about the fish shell. Don\'t judge me. '\n'https://github.com/zQueal'\n
end

function vhost
  for i in (options $argv)
    echo $i | read -l option value
    switch $option
      case h help
	fhelp
	return 0
      case l list
	echo Available Sites:
	echo (ls /etc/nginx/sites-available/)
	echo \nEnabled Sites:
	echo (ls /etc/nginx/sites-enabled/)
	return 0
      case rm remove
	chown -R 1000 /etc/nginx/sites-available/
	echo Removing $value...
	if read_confirm
	  if test -e /etc/nginx/sites-available/$value
		rm /etc/nginx/sites-available/$value
		rm /etc/nginx/sites-enabled/$value
		echo $value has been removed.
		return 0
	  else
		echo Could not remove $value... Does it exist?
		return 1
	  end
        end
      case c create
	touch /etc/nginx/sites-available/$value
	ln -s /etc/nginx/sites-available/$value /etc/nginx/sites-enabled/$value
	chown -R 1000 /etc/nginx/
	begin
	  echo 'server {
	listen 80 default_server;
	root /home/teamspeak/'$value';
    	index index.php index.html index.htm;
    	server_name '$value'; # FQDN
    	location / {
           try_files $uri $uri/ =404;
    	}
    	location ~ \.php$ {
           try_files $uri =404;
	   fastcgi_split_path_info ^(.+\.php)(/.+)$;
           fastcgi_pass unix:/var/run/php5-fpm.sock;
	   fastcgi_index index.php;
           include fastcgi_params;
    	}
    	location ~ /\.ht {
           deny all;
    	}
}'
	end > /etc/nginx/sites-available/$value
	if test -e /etc/nginx/sites-available/$value
	  echo Complete!
	  return 0
	else
	  echo Could not write or create $value configuration. Exiting.
	  return 1
	end
      case a about
	fabout
    end
  end 
end
