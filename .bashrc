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
    alias sst="squeue --start -u bwilfong3"
fi

if [[ $(hostname) =~ "andes" ]];
then
    alias mw="cd /lustre/orion/cfd154/scratch/bwilfong3"
    function gint() { salloc -q debug -t 02:00:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 --gpu-bind=closest -A cfd154;}
    alias l=". ./mfc.sh load -c f -m g"
    alias s="squeue -u bwilfong3"
    alias sst="squeue --start -u bwilfong3"
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

    if [[ $(grep VERSION_ID /etc/os-release) =~ "9.4" ]];
    then
        alias vim="/storage/home/hcoda1/6/bwilfong3/software/vim/src/vim"
        export VIMRUNTIME=/storage/home/hcoda1/6/bwilfong3/software/vim/runtime
    else
        alias vim="/storage/home/hcoda1/6/bwilfong3/software/vimRH7/src/vim"
        export VIMRUNTIME=/storage/home/hcoda1/6/bwilfong3/software/vim/runtime
    fi
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

fi

if [[ $(hostname) =~ "delta" ]];
then
    alias mw="cd /scratch/bdiy/bwilfong"
    alias s="squeue -u bwilfong"
    alias l=". ./mfc.sh load -c d -m g"
    function gint() { salloc -t 0$3:00:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 -A bdiy-delta-gpu;}
    function cint() { salloc -t 0$3:00:00 -p cpu -N $1 --ntasks-per-node=$2 -A bdiy-delta-cpu;}
    alias sst="squeue --start -u bwilfong"
fi

if [[ $(hostname) =~ "gh-login" ]];
then
    alias mw="cd /work/nvme/bbsc/bwilfong"
    alias s="squeue -u bwilfong"
    alias l=". ./mfc.sh load -c da -m g"
    function gint() { salloc -t 0$3:00:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 -A bbsc-delta-gpu;}
    function cint() { salloc -t 0$3:00:00 -p cpu -N $1 --ntasks-per-node=$2 -A bbsc-delta-cpu;}
    alias sst="squeue --start -u bwilfong"
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

set -o vi
# Go to scratch directory
mw
