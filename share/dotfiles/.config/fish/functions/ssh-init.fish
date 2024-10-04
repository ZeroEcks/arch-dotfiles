function ssh-init -d "Creates a ed25519 key and adds it to the ssh-agent" -a email
    if test -z "$email"
        return 1
    else
        ssh-keygen -t ed25519 -C $email
        eval "$(ssh-agent -c)" && ssh-add --apple-use-keychain ~/.ssh/id_ed25519
    end
end
