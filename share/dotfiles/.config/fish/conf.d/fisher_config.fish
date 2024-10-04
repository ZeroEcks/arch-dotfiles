set fisher_path ~/.config/fish/fisher

! set --query fisher_path[1] || test "$fisher_path" = $__fish_config_dir && exit

set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

for file in $fisher_path/conf.d/*.fish
    source $file
end

if not type -q fisher
    echo "`fisher` is not installed, install with `curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher` or check https://github.com/jorgebucaran/fisher"
end

