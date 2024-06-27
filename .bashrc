# Fetching latest .bashrc
if shopt -q login_shell;
then
    cd ~/dotFiles
    git pull

    \cp ~/dotFiles/.bashrc ~/.bashrc
    \cp ~/dotFiles/.vimrc ~/.vimrc
fi


# Computer specific aliases
if [[ $(hostname -f) =~ "frontier" ]];
then
    alias mw="cd /lustre/orion/cfd154/scratch/bwilfong3"
    function gint() { salloc -q debug -t 02:00:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 --gpu-bind=closest -A cfd154;}
    alias l=". ./mfc.sh load -c f -m g"
    alias s="squeue -u bwilfong3"
fi

if [[ $(hostname) =~ "andes" ]];
then
    alias mw="cd /lustre/orion/cfd154/scratch/bwilfong3"
    function gint() { salloc -q debug -t 02:00:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 --gpu-bind=closest -A cfd154;}
    alias l=". ./mfc.sh load -c f -m g"
    alias s="squeue -u bwilfong3"
fi

if [[ $(hostname) =~ "delta" ]];
then
    alias mw="cd /scratch/bbsc/bwilfong"
    alias s="squeue -u bwilfong"
    alias l=". ./mfc.sh load -c d -m g"
    function gint() { salloc -t 0$3:00:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 -A bbsc-delta-gpu;}
    function cint() { salloc -t 0$3:00:00 -N $1 --ntasks-per-node=$2 -A bbsc-delta-cpu;}
fi

if [[ $(hostname) =~ "phoenix" ]];
then
    function gint() { salloc -q embers -t 0$3:00:00 -N $1 --ntasks-per-node=$2 --gres=gpu:$4:$2 -A gts-sbryngelson3; }
    function cint() { salloc -q embers -t 0$3:00:00 -N $1 --ntasks-per-node=$2 -A gts-sbryngelson3; }
    alias l=". ./mfc.sh load -c p -m g"
    alias s="squeue -u bwilfong3"
    alias mw="cd /storage/home/hcoda1/6/bwilfong3/scratch"
    alias ag="sinfo | grep gpu | grep idle"
    alias ac="sinfo | grep cpu | grep idle"
    alias vim="/storage/home/hcoda1/6/bwilfong3/software/vim/src/vim"
fi

if [ $(hostname) = "wingtip-gpu3" ];
then
    alias mw="cd /fastscratch/bwilfong3"
    alias s="nvidia-smi"
fi

# General aliases
alias d="ls"
alias df="cd ~/dotFiles"
alias bs="source ~/.bashrc"
alias c="clear"
alias e="exit"
alias si="sinfo"
alias sq="squeue"
alias h="cd ~/"
alias sls="screen -l"
alias sa="screen -r"
alias sr="rocm-smi"
alias ns="nvidia-smi"

# Go to scratch directory
mw
