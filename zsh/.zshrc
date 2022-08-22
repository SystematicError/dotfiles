# Start x server on login
if [ "$(tty)" = "/dev/tty1" ]; then
    sx
    killall picom pipewire gnome-polkit > /dev/null 2>&1
fi

# Theme tty
if [ "$TERM" = "linux" ]; then
    printf "
        \e]P00f0f0f
        \e]P1fc4e4e
        \e]P2bbef6e
        \e]P3ffaf60
        \e]P46aa4cc
        \e]P58d8bc4
        \e]P696e0c9
        \e]P7e8e8e8
        \e]P8404040
        \e]P9ff6565
        \e]PAc5ec8e
        \e]PBf6cd7e
        \e]PC82b4d6
        \e]PDac9dcc
        \e]PEb8e5ec
        \e]PFbababa
    "
    clear
fi


# Custom Extensions
source ~/.config/zsh/extensions/autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/extensions/syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# History
HISTFILE=~/.config/zsh/history
HISTSIZE=100
SAVEHIST=500

# Aliases
alias sudo='sudo ' # Make sudo work with aliases
alias git="TZ=UTC git" # Hotfix for patch file creation

alias grep="grep -i" # Case insensitive grep
alias rg="rg -S" # Smart case ripgrep

alias ls="lsd -A" # Ls command with icons
alias lt="lsd -A --tree" # Recursively list files as tree
alias ll="lsd -Al" # List files with verbose info

alias awlog="tail -f /tmp/awesome.log" # Display window manager logs
# Screenshots
alias awshot="awesome-client 'require(\"widgets.screenshot\").free()'"
alias awshot-client="awesome-client 'require(\"widgets.screenshot\").client()'"
alias awshot-screen="awesome-client 'require(\"widgets.screenshot\").screen()'"

alias pac="pacman" # Short hand for package manager
alias cl="clear" # Short hand for clearing screen
alias nv="nvim" # Short hand for text editor
alias :q="exit" # Useful when I accidentally type this after working in vim

# Custom prompt
export STARSHIP_CONFIG=~/.config/starship/config.toml
eval "$(starship init zsh)"

# Patch delete key for zsh
tput smkx
bindkey "^[[3~" delete-char

# Custom fetch / greeter
~/.config/zsh/coffee

