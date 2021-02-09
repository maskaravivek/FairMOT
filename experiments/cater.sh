#!/bin/bash
#SBATCH -N 1                        # number of cores
#SBATCH --mem=12G
#SBATCH -n 6
#SBATCH -t 4-12:00
#SBATCH -p gpu
#SBATCH -q wildfire
#SBATCH -o nuclei.out             # STDOUT (%j = JobId)
#SBATCH --gres=gpu:2     #number of GPU required
#SBATCH --mail-type=ALL             # Send a notification when the job starts, stops, or fails
#SBATCH --mail-user=vmaskara@asu.edu # send-to address
# Always purge modules to ensure a consistent environment

module load anaconda3/5.3.0
module load cuda/10.2.89

# change environment name
source  activate FairMOT

#pip install --user DCNv2

cd /home/vmaskara/thesis/DCNv2
./make.sh

cd /home/vmaskara/thesis/FairMOT
cd src
python train.py mot --exp_id cater_fairmot --data_cfg '../src/lib/cfg/cater.json'
cd ..
