#!/bin/bash
export PATH="/slurm_data/anaconda3/envs/qwen2/bin:$PATH"

# set network info
case "$SLURM_JOB_PARTITION" in
    GPU)
        export GLOO_SOCKET_IFNAME="enp129s0f0"
        echo "GLOO_SOCKET_IFNAME set to enp129s0f0 for partition GPU"
        ;;
    GPU-4)
        export GLOO_SOCKET_IFNAME="eno1"
        echo "GLOO_SOCKET_IFNAME set to eno1 for partition GPU-4"
        ;;
    *)
        echo "Error: Unsupported partition '$SLURM_JOB_PARTITION'."
        exit 1
        ;;
esac


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
    --ckpt_dir outputs/qwen2_5_3b_baseline/ckpt \
    --load_dataset_config true \
    --val_dataset vlm_dataset/vlm_baseline_test.json \
    --logprobs true