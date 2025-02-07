# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Bash parameter completion for the dotnet CLI
function _dotnet_bash_complete() {
  local cur="${COMP_WORDS[COMP_CWORD]}" IFS=$'\n'
  local candidates

  read -d '' -ra candidates < <(dotnet complete --position "${COMP_POINT}" "${COMP_LINE}" 2>/dev/null)
  read -d '' -ra COMPREPLY < <(compgen -W "${candidates[*]:-}" -- "$cur")
}

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
export PATH="$HOME/.cargo/bin:$HOME/.yarn/bin:$PATH"
export EDITOR=nvim
export PATH=$PATH:/usr/local/go/bin

complete -f -F _dotnet_bash_complete dotnet

# Terminal tools
if [ -z "$DISTROBOX_ENTER_PATH" ]; then
    # Normal environment settings
    eval "$(atuin init bash)"
    eval "$(starship init bash)"
    eval "$(zoxide init bash)"
else
    echo "Running inside Distrobox, skipping atuin and starship setup."

    # Set a compatible terminal type to avoid errors
    export TERM=xterm-256color
fi
