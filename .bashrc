# Fetching latest .bashrc
if [[ $(hostname -f) =~ "login" ]];
then
    cd ~/dotFiles
    git pull

    \cp ~/dotFiles/.bashrc ~/.bashrc
    \cp ~/dotFiles/.vimrc ~/.vimrc
fi

if [ $(hostname) = "wingtip-gpu3" ];
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
    alias ps="cd /gpfs/alpine/cfd154/proj-shared"
    function gint() { salloc -q debug -t 02:00:00 -N $1 --gpus-per-node=8 --ntasks-per-node=$2 --gpu-binde=closes -A gts-sbryngelson8; }
    alias l=". ./mfc.sh load -c s -m g"
    alias s="squeue -u bwilfong3"
fi

if [[ $(hostname) =~ "delta" ]];
then
    alias mw="cd /scratch/bbsc/bwilfong"
    alias s="squeue -u bwilfong"
    alias l=". ./mfc.sh load -c d -m g"
fi

if [[ $(hostname) =~ "phoenix" ]];
then
    alias l=". ./mfc.sh load -c p -m g"
    function gint() { salloc -q embers -t 0$3:00:00 -N $1 --ntasks-per-node=$2 --gres=gpu:$4:$2 -A gts-sbryngelson8; }
    function cint() { salloc -q embers -t 0$3:00:00 -N $1 --ntasks-per-node=$2 -A gts-sbryngelson3; }
    alias l=". ./mfc.sh load -c p -m g"
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
alias sr="screen -r"
alias sr="rocm-smi"
alias ns="nvidia-smi"

# Go to scratch directory
mw
