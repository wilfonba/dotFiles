cd ~/dotFiles
git pull --quiet
cp ~/dotFiles/.zshrc ~/.zshrc
cp ~/dotFiles/.vimrc ~/.vimrc
cp ~/dotFiles/.p10k.zsh ~/.p10k.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"
#
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(vi-mode)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ $(hostname) =~ "delta" ]];
then
    alias mw="cd /scratch/bdiy/bwilfong"
    alias s="squeue -u bwilfong"
    alias l=". ./mfc.sh load -c d -m g"
    function gint() { salloc -t 0$3:00:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 -A bdiy-delta-gpu;}
    function cint() { salloc -t 0$3:00:00 -p cpu -N $1 --ntasks-per-node=$2 -A bdiy-delta-cpu;}
    alias sst="squeue --start -u bwilfong"
    export VIM_ANG_REV="0"
fi

if [[ $(uname) =~ "Darwin" ]]; # My laptop
then
    alias vim="/opt/homebrew/Cellar/macvim/9.1.0727_1/bin/vim" 
    export VIM_HOME="/usr/local/Cellar/vim/8.2.2100/"
    export PATH=$PATH:$VIM_HOME/bin
    alias mw="cd ~/Documents"
    source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
    source /opt/homebrew/opt/chruby/share/chruby/auto.sh
    chruby ruby-3.1.3
    alias bw="bundle exec jekyll serve"

    function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }
    export VIM_ANG_REV="1"
fi

if [ $(hostname) = "wingtip-gpu3" ];
then
    source /usr/share/lmod/lmod/init/zsh
    alias mw="cd /fastscratch/bwilfong3"
    alias s="nvidia-smi"
    export VIM_ANG_REV="1"
    export TMPDIR=$HOME/tmp
    source ~/fastScratch/pythonEnv/bin/activate
    alias pvserver="/fastscratch/bwilfong3/software/ParaView-5.11.2-egl-MPI-Linux-Python3.9-x86_64/bin/pvserver"
    alias pvpython="/fastscratch/bwilfong3/software/ParaView-5.11.2-egl-MPI-Linux-Python3.9-x86_64/bin/pvpython"

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    export PATH="$HOME/local/vim/bin:$PATH"
fi

if [[ $(hostname) =~ "phoenix" ]] || [[ $(hostname) =~ "atl" ]];
then
    function gint() { salloc -q embers -t 0$3:00:00 -N $1 --ntasks-per-node=$2 --gres=gpu:$4:$2 -A gts-sbryngelson3; }
    function cint() { salloc -q embers -t 0$3:00:00 -N $1 --ntasks-per-node=$2 -A gts-sbryngelson3; }
    alias l=". ./mfc.sh load -c p -m g"
    alias s="squeue -u bwilfong3"
    alias mw="cd /storage/home/hcoda1/6/bwilfong3/scratch"
    alias ag="sinfo | grep gpu | grep idle"
    alias ac="sinfo | grep cpu | grep idle"
    alias sst="squeue --start -u bwilfong3"

    export VIM_ANG_REV="1"
fi

if [[ $(hostname) =~ "crnch" ]] || [[ $(hostname) =~ "uwing" ]];
then
    function gint() { salloc -q embers -t 0$3:00:00 -N $1 --ntasks-per-node=$2 --gres=gpu:$4:$2 -A gts-sbryngelson3; }
    function cint() { salloc -q embers -t 0$3:00:00 -N $1 --ntasks-per-node=$2 -A gts-sbryngelson3; }
    alias l=". ./mfc.sh load -c p -m g"
    alias s="squeue -u bwilfong3"
    alias mw="cd /nethome/bwilfong3/USERSCRATCH"
    alias ag="sinfo | grep gpu | grep idle"
    alias ac="sinfo | grep cpu | grep idle"
    alias sst="squeue --start -u bwilfong3"

    source_profile_files()
    {
        #We assume that all relevant modulefiles are specified
        #in profile.d, regardless of the system
        local PROFILE_DIR=/etc/profile.d

        #Specify an array of files - note not all of these exist on all
        #nodes
        files=(
        "$PROFILE_DIR/bash_completion.sh"
        "$PROFILE_DIR/doca-runtime.sh"
        "$PROFILE_DIR/doca-sdk-x86_64-linux-gnu.sh"
        "$PROFILE_DIR/lmod.sh"
        "$PROFILE_DIR/modules.sh"
        "$PROFILE_DIR/slurm.sh"
        "$PROFILE_DIR/y00_slurm.sh"
        "$PROFILE_DIR/y01_ubuntu20_modules.sh"
        "$PROFILE_DIR/y01_rhel8_modules.sh"
        "$PROFILE_DIR/y02_rg_local_modules.sh"
        )

        local file

        #Iterate over all the files and source ones that exist
        for file in "${files[@]}"; do

           if [[ -f "$file" ]]; then  # Check if the file exists and is a regular file
             source "$file"
               fi
            done
    }

    #Call the main function
    source_profile_files

    export VIM_ANG_REV="1"
fi

if [[ $(hostname -f) =~ "frontier" ]];
then
    alias mw="cd /lustre/orion/cfd154/scratch/bwilfong3"
    alias mws="cd /lustre/orion/eng160/scratch/bwilfong3"
    function gint() { salloc -q debug -t 02:00:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 --gpu-bind=closest -A cfd154;}
    alias l=". ./mfc.sh load -c f -m g"
    alias s="squeue -u bwilfong3"
    alias sst="squeue --start -u bwilfong3"
    export VIM_ANG_REV="1"
fi

if [[ $(hostname) =~ "andes" ]];
then
    alias mw="cd /lustre/orion/cfd154/scratch/bwilfong3"
    function gint() { salloc -q debug -t 02:00:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 --gpu-bind=closest -A cfd154;}
    alias l=". ./mfc.sh load -c f -m g"
    alias s="squeue -u bwilfong3"
    alias sst="squeue --start -u bwilfong3"
    export VIM_ANG_REV="1"
fi

# General aliases
alias d="ls"
alias bs="source ~/.bashrc"
alias zs="source ~/.zshrc"
alias c="clear"
alias e="exit"
alias si="sinfo"
alias sq="squeue"
alias h="cd ~/"
alias sls="screen -l"
alias sa="screen -r"
alias sr="rocm-smi"
alias ns="nvidia-smi"
alias cl="wc -l *"
alias gppd="g++ -std=c++17 -O2 -DNDEBUG"
alias gpp="g++ -std=c++17 -ggdb"
alias vim="vim -u ~/.vimrc"

bindkey -v
mw

