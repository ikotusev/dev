PS1='\w\$ '
HISTCONTROL=ignoredups:ignorespace
alias grep='grep --color=auto'
alias vi=vim
export EDITOR=vim
export PAGER=less
eval "$(direnv hook bash)"
eval "$(pip completion --bash)"
. /usr/share/bash-completion/completions/git
test -f ~/.ssh-agent && . ~/.ssh-agent >/dev/null
test -d /proc/${SSH_AGENT_PID:-X} || eval `ssh-agent|tee ~/.ssh-agent`
