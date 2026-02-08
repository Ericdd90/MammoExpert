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
export OUT_DIR="outputs/qwen2_5_3b_reasoning"

swift sft \
   --model /path/to/modelscope/models/Qwen/Qwen2.5-VL-3B-Instruct \
   --train_type lora \
   --freeze_llm False \
   --freeze_vit False \
   --freeze_aligner False \
   --lora_rank 16 \
   --lora_alpha 16 \
   --output_dir $OUT_DIR \
   --dataset vlm_dataset/vlm_reasoning_trainval.json \
   --val_dataset vlm_dataset/vlm_reasoning_test.json \
   --split_dataset_ratio 0.0 \
   --use_hf False \
   --max_steps 4000 \
   --max_length 2048 \
   --gradient_checkpointing True \
   --gradient_checkpointing_kwargs '{"use_reentrant": false}' \
   --per_device_train_batch_size 1 \
   --weight_decay 0.1 \
   --warmup_ratio 0.1 \
   --eval_steps 2000 \
   --save_steps 2000 \
   --save_total_limit -1 \
   --logging_steps 10 \
   --learning_rate 1e-4 \
   --lr_scheduler_type cosine \
   --acc_strategy seq \
   --add_version False \
   --attn_impl flash_attn \
   --seed 50
