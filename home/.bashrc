#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Custom config
eval "$(ssh-agent -s)" >/dev/null 2>&1
ssh-add ~/.ssh/personal-github-key >/dev/null 2>&1
ssh-add ~/.ssh/school-gitlab-key >/dev/null 2>&1
