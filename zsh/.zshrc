# Enable colors and change prompt
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd 		# Automatically cd into typed directory
stty stop undef 	# Disable <C-s> to freeze terminal

export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history
export HISTTIMEFORMAT="%F %T "

function source-if-exists()
{
	[ -f "$1" ] && source "$1"
}

# Load aliases and shortcuts if existent.
source-if-exists "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
source-if-exists "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

function block-cursor() {
	echo -ne '\e[1 q'
}
function beam-cursor() {
	echo -ne '\e[5 q'
}

# Change cursor shape for different vi modes.
function zle-keymap-select () {
	case $KEYMAP in
		vicmd) block-cursor;;		# Block
		viins|main) beam-cursor;;	# Beam
	esac
}

zle -N zle-keymap-select

function zle-line-init () {
	zle -K viins	# Initiate `vi insert` as keymap.
	beam-cursor
}

zle -N zle-line-init
beam-cursor 			# Use beam cursor on startup.
preexec() { beam-cursor ;}	# Use beam cursor for each new prompt.

# Edit line in vim with <C-e>
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load the pywal colorscheme
[ -f ~/.cache/wal/sequences ] && (cat ~/.cache/wal/sequences &)

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

