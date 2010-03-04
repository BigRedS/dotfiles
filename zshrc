# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/avi/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


PROMPT=$'%{\e[0;36m%}%n@%m:%~%{\e[0m%}%# ' 
RPROMPT=$'%{\e[0;35m%}%*%{\e[0m%}'
