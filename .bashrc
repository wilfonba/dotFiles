# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

cd ~/dotFiles
git pull

\cp ~/dotFiles/.bashrc ~/.bashrc
\cp ~/dotFiles/.vimrc ~/.vimrc

# Path to your oh-my-bash installation.

if [[ $(hostname) =~ Andes ]]; 
then 
    export OSH='/ccs/home/bwilfong3/.oh-my-bash';
fi

if [[ $(hostname -f) =~ "frontier" ]]; 
then 
    export OSH='/ccs/home/bwilfong3/.oh-my-bash';
    alias mw="cd /lustre/orion/cfd154/scratch/bwilfong3"
    alias h="cd /ccs/home/bwilfong3"
    alias ps="cd /gpfs/alpine/cfd154/proj-shared"
    alias int="bsub -Is -nnodes 1 -P cfd154 -W 02:00 $SHELL"
    alias se="export CRAY_ACC_MODULE=/lustre/orion/cfd154/scratch/bwilfong3/software/MFC-AMD/build/simulation/simulation-wg256.lld.exe"
    alias hint="salloc -A cfd154 --nodes=1 --gpus-per-node=8 --ntasks-per-node=8 --gpu-bind=closest -J interactive -t 2:00:00 -q debug"
    alias fint="salloc -A cfd154 -J thing -t 2:00:00 -q debug -N 1"
    alias l=". ./mfc.sh load -c s -m g"
    alias s="squeue -u bwilfong3"
    alias b="bjobs -u bwilfong3"
    alias c="clear"
    alias e="exit"
    alias si="sinfo"
    alias sq="squeue"
    alias ss="squeue --start"
fi

if [[ $(hostname) =~ "delta" ]]; 
then 
    export OSH='/u/bwilfong/.oh-my-bash';
    alias mw="/scratch/bbsc/bwilfong"
fi

if [[ $(hostname) =~ "phoenix" ]]; 
then 
    export OSH='/storage/home/hcoda1/6/bwilfong3/.oh-my-bash';
fi

if [ $(hostname) = "wingtip-gpu3" ];
then
    export OSH='/nethome/bwilfong3/.oh-my-bash';
fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="powerline-icon"
POWERLINE_PROMPT_USER_INFO_MODE="sudo"
POWERLINE_PROMPT="scm cwd in_vim"
# If you set OSH_THEME to "random", you can ignore themes you don't like.
# OMB_THEME_RANDOM_IGNORED=("powerbash10k" "wanelo")

# Uncomment the following line to use case-sensitive completion.
# OMB_CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# OMB_HYPHEN_SENSITIVE="false"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you don't want the repository to be considered dirty
# if there are untracked files.
# SCM_GIT_DISABLE_UNTRACKED_DIRTY="true"

# Uncomment the following line if you want to completely ignore the presence
# of untracked files in the repository.
# SCM_GIT_IGNORE_UNTRACKED="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.  One of the following values can
# be used to specify the timestamp format.
# * 'mm/dd/yyyy'     # mm/dd/yyyy + time
# * 'dd.mm.yyyy'     # dd.mm.yyyy + time
# * 'yyyy-mm-dd'     # yyyy-mm-dd + time
# * '[mm/dd/yyyy]'   # [mm/dd/yyyy] + [time] with colors
# * '[dd.mm.yyyy]'   # [dd.mm.yyyy] + [time] with colors
# * '[yyyy-mm-dd]'   # [yyyy-mm-dd] + [time] with colors
# If not set, the default value is 'yyyy-mm-dd'.
# HIST_STAMPS='yyyy-mm-dd'

# Uncomment the following line if you do not want OMB to overwrite the existing
# aliases by the default OMB aliases defined in lib/*.sh
# OMB_DEFAULT_ALIASES="check"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# To disable the uses of "sudo" by oh-my-bash, please set "false" to
# this variable.  The default behavior for the empty value is "true".
OMB_USE_SUDO=true

# To enable/disable display of Python virtualenv and condaenv
# OMB_PROMPT_SHOW_PYTHON_VENV=true  # enable
# OMB_PROMPT_SHOW_PYTHON_VENV=false # disable

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

source "$OSH"/oh-my-bash.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

POWERLINE_PROMPT_USER_INFO_MODE="sudo"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"

alias d="ls"
alias df="cd ~/dotFiles"
alias bs="source ~/.bashrc"

