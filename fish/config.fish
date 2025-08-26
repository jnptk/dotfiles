set -x XDG_CONFIG_HOME $HOME/.config
set -x EDITOR nvim
set -x PYENV_ROOT $HOME/.pyenv
fish_add_path -p $HOME/.local/bin
fish_add_path -p $PYENV_ROOT/bin
fish_add_path -a /opt/homebrew/bin/

status is-interactive; and begin
    # aliases
    alias gs 'git status'
    alias fishconfig 'nvim $XDG_CONFIG_HOME/fish/config.fish'

    alias ls 'lsd'
    alias la 'lsd -a'
    alias ll 'lsd -l'
    alias lt 'lsd --tree'

    # disable fish greeting
    set fish_greeting
    fish_config theme choose 'Solarized Dark'

    set -x HOMEBREW_NO_AUTO_UPDATE 1
    set -x HOMEBREW_NO_ENV_HINTS 1
    set -x FZF_DEFAULT_OPTS '--no-color'

    starship init fish | source
    pyenv init - fish | source
    fzf --fish | source
end
