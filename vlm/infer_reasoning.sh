# set distributed training
export MASTER_ADDR=$(scontrol show hostname $SLURM_NODELIST | head -n 1)
export MASTER_PORT=23583  # set your own port
export NNODES=$SLURM_NNODES
export NODE_RANK=$SLURM_NODEID
export NPROC_PER_NODE=8

cur_dir=$(dirname "$0")
cur_dir=$(realpath $cur_dir)
export MODELSCOPE_CACHE="$cur_dir/modelscope"

export MAX_PIXELS=94864 # 11*11 token 308*308
export MIN_PIXELS=78400  # 10*10 token 280*280
export OMP_NUM_THREADS=1

swift infer \
    --ckpt_dir outputs/qwen2_5_3b_reasoning/ckpt \
    --load_dataset_config true \
    --val_dataset vlm_dataset/vlm_reasoning_test.json \
    --logprobs true