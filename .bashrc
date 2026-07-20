# Fetching latest .bashrc
if ping -q -c 1 -W 2 8.8.8.8 > /dev/null;
then
    cd ~/dotFiles
    git pull --quiet

    \cp ~/dotFiles/.bashrc ~/.bashrc
    \cp ~/dotFiles/.vimrc ~/.vimrc
    \cp ~/dotFiles/.zshrc ~/.zshrc
    \cp ~/dotFiles/.tmux.conf ~/.tmux.conf
fi

# Install TPM (tmux plugin manager) if it's missing
if command -v tmux >/dev/null 2>&1 && [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone --quiet https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null
fi

# Computer specific aliases
if [[ $(hostname -f) =~ "frontier" ]];
then
    alias mwd="cd /lustre/orion/cfd154/scratch/bwilfong3"
    alias mwds="cd /lustre/orion/eng160/scratch/bwilfong3"
    function gint() { salloc -q debug -t 00:$3:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 --gpu-bind=closest -A $4 -q debug;}
    function hint() { salloc -q debug -t 00:$3:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 --gpu-bind=closest -A $4 --reservation=hackathon3;}
    alias l=". ./mfc.sh load -c f -m g"
    alias s="squeue -u bwilfong3 -o \"%.18i %.9P %.30j %.8u %.8T %.10M %.9l %.6D %R\""
    alias sst="squeue --start -u bwilfong3"
    export PATH="/ccs/home/bwilfong3/node-v22.16.0-linux-x64/bin:$PATH"
    export PATH="$HOME/.local/bin:$PATH"
fi

if [[ $(hostname -f) =~ "tuolumne" ]];
then
    alias mwd="cd /p/lustre5/wilfong1"
    alias mwdw="cd /usr/workspace/wilfong1"
    alias l=". ./mfc.sh load -c tuo -m g"
    function gint() { flux alloc -t $2 -N $1 -q pdebug; }
    alias s="flux jobs"
    stty erase '^?' # Working backspace in vim
fi

if [[ $(hostname -f) =~ "tioga" ]];
then
    alias mwd="cd /p/lustre1/wilfong1"
    alias mwdt="cd /p/lustre2/wilfong1"
    alias l=". ./mfc.sh load -c tga -m g"
    function gint() { flux alloc -t $2 -N $1 -q pdebug; }
    alias s="flux jobs"
    stty erase '^?' # Working backspace in vim
fi

if [[ $(hostname -f) =~ "ufhpc" ]];
then
    alias mw="cd /blue/bala1s/bwilfong"
    function gint() { salloc -t $3:00:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 --gpu-bind=closest -p hpg-b200  -A bala1s;}
    function cint() { salloc -t $3:00:00 -N $1 --ntasks-per-node=$2 -p hpg-milan -A bala1s;}
    alias l=". ./mfc.sh load -c h -m g"
    alias s="squeue -u bwilfong -o \"%.18i %.9P %.30j %.8u %.8T %.10M %.9l %.6D %R\""
    alias sst="squeue --start -u bwilfong"
fi

if [[ $(hostname) =~ "andes" ]];
then
    alias mwd="cd /lustre/orion/cfd154/scratch/bwilfong3"
    alias mwds="cd /lustre/orion/eng160/scratch/bwilfong3"
    function gint() { salloc -q debug -t 02:00:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 --gpu-bind=closest -A cfd154;}
    alias l=". ./mfc.sh load -c f -m g"
    alias s="squeue -u bwilfong3 -o \"%.18i %.9P %.30j %.8u %.8T %.10M %.9l %.6D %R\""
    alias sst="squeue --start -u bwilfong3"
    export PATH="$HOME/.local/bin:$PATH"
fi

if [[ $(hostname) =~ "phoenix" ]] || [[ $(hostname) =~ "atl" ]];
then
    function gint() { salloc -q embers -t 0$3:00:00 -N $1 --ntasks-per-node=$2 --gres=gpu:$4:$2 -A gts-sbryngelson3; }
    function cint() { salloc -q embers -t 0$3:00:00 -N $1 --ntasks-per-node=$2 -A gts-sbryngelson3 -C graniterapids; }
    alias l=". ./mfc.sh load -c p -m g"
    alias s="squeue -u bwilfong3 -o \"%.18i %.9P %.30j %.8u %.8T %.10M %.9l %.6D %R\""
    alias mwd="cd /storage/scratch1/6/bwilfong3"
    alias sst="squeue --start -u bwilfong3"
    export PATH="/usr/bin:$HOME/.local/bin:$PATH" # Claude code
fi

if [[ $(hostname) =~ "ice" ]];
then
    alias l=". ./mfc.sh load -c p -m g"
    alias s="squeue -u bwilfong3 -o \"%.18i %.9P %.30j %.8u %.8T %.10M %.9l %.6D %R\""
    alias mwd="cd /home/hice1/bwilfong3/scratch"
    alias sst="squeue --start -u bwilfong3"
fi

if [[ $(hostname) =~ "crnch" ]] || [[ $(hostname) =~ "uwing" ]];
then
    function gint() { salloc -q embers -t 0$3:00:00 -N $1 --ntasks-per-node=$2 --gres=gpu:$4:$2 -A gts-sbryngelson3; }
    function cint() { salloc -q embers -t 0$3:00:00 -N $1 --ntasks-per-node=$2 -A gts-sbryngelson3; }
    alias l=". ./mfc.sh load -c p -m g"
    alias s="squeue -u bwilfong3 -o \"%.18i %.9P %.30j %.8u %.8T %.10M %.9l %.6D %R\""
    alias mwd="cd /nethome/bwilfong3/USERSCRATCH"
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
    alias mwd="cd /scratch/bdiy/bwilfong"
    alias s="squeue -u bwilfong -o \"%.18i %.9P %.30j %.8u %.8T %.10M %.9l %.6D %R\""
    alias l=". ./mfc.sh load -c d -m g"
    function gint() { salloc -t 0$3:00:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 -A bdiy-delta-gpu;}
    function cint() { salloc -t 0$3:00:00 -p cpu -N $1 --ntasks-per-node=$2 -A bdiy-delta-cpu;}
    alias sst="squeue --start -u bwilfong"
fi

if [[ $(hostname) =~ "gh-login" ]] || [[ $(hostname) =~ "hsn.cm.delta.internal.ncsa.edu" ]];
then
    alias mwd="cd /work/nvme/bbsc/bwilfong"
    alias s="squeue -u bwilfong -o \"%.18i %.9P %.30j %.8u %.8T %.10M %.9l %.6D %R\""
    alias l=". ./mfc.sh load -c dai -m g"
    function gint() { salloc -t 0$3:00:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 -A bbsc-dtai-gh -p ghx4-interactive;}
    function cint() { salloc -t 0$3:00:00 -p cpu -N $1 --ntasks-per-node=$2 -A bbsc-dtai-gh;}
    alias sst="squeue --start -u bwilfong"
fi

if [[ $(hostname -f) =~ "daint" ]];
then
    alias mwd="cd /capstor/scratch/cscs/bwilfong"
    function gint() { salloc -t 00:$3:00 -N $1 --gpus-per-node=$2 --ntasks-per-node=$2 --gpu-bind=closest -A g183;}
    alias l=". ./mfc.sh load -c san -m g"
    alias s="squeue -u bwilfong -o \"%.18i %.9P %.30j %.8u %.8T %.10M %.9l %.6D %R\""
    alias sst="squeue --start -u bwilfong"
    alias us="uenv start --view=modules icon/25.2:v1@santis"
    alias up="uenv start --view=develop /capstor/scratch/cscs/bwilfong/uenvs/paraview-silo-gh200-egl-5.13.2-2025-08-07.squashfs"
fi

if [[ $(hostname -f) =~ "hpcfund" ]];
then
    alias mwd="cd /work1/spencerbryngelson/bwilfong3"
    alias sst="squeue --start -u bwilfong3"
    alias s="squeue -u bwilfong3 -o \"%.18i %.9P %.30j %.8u %.8T %.10M %.9l %.6D %R\""
fi

if [ $(hostname) = "wingtip-gpu3" ];
then
    alias mwd="cd /fastscratch/bwilfong3"
    alias s="nvidia-smi"
    export PATH=$HOME/.local/bin:$PATH
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

alias ag="sinfo | grep gpu | grep idle"
alias ac="sinfo | grep cpu | grep idle"
alias vim="vim -u ~/.vimrc"

alias tas="tmux attach-session -t"
alias trs="tmux rename-session -t"
alias tks="tmux kill-session -t"
alias tls="tmux ls"

function td() { tree -L "${1:-2}" -P "*.tar.gz|*.zip";}

set -o vi
# Go to scratch directory
mwd
