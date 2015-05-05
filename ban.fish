function ban --description 'ban all ip addresses using ufw'
        for val in $argv
                ufw insert 1 deny from $val
        end
end
