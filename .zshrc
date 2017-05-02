# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Add local/bin to path
export PATH="$HOME/local/bin:$PATH"


# Source FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Configure virtualenvwrapper
if [[ -s "/usr/share/virtualenvwrapper/virtualenvwrapper.sh" ]]; then
  # Set the directory where virtual environments are stored.
  export WORKON_HOME="${WORKON_HOME:-$HOME/.virtualenvs}"
  export PROJECT_HOME=$HOME/workspace

  # Disable the virtualenv prompt.
  # Uncomment this line once pure theme adds support to show active virtualenv
  #VIRTUAL_ENV_DISABLE_PROMPT=1

  source "/usr/share/virtualenvwrapper/virtualenvwrapper.sh"
fi
