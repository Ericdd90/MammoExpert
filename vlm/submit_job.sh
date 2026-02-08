mkdir -p joblogs
mkdir -p outputs

module load cuda/12.1.1


srun sh ./train_reasoning.sh
srun sh ./infer_reasoning.sh
srun sh ./train_baseline.sh
srun sh ./infer_baseline.sh