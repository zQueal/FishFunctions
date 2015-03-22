function pastebin --description 'Paste something online using ix.io'
	cat $argv ^/dev/null | curl -ns -F 'f:1=<-' 'http://ix.io' | read -l url
        set extension (echo $argv | rev | cut -d '.' -f 1 | rev)
        if [ ! -z $extension ]
            set url $url/$extension
        end
        echo $url
end
