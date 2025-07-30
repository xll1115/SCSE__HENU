export CUDA_VISIBLE_DEVICES=1
lmdeploy serve api_server /home/zhaoyang/LLM_Weight/Qwen2-0.5B-Instruct \
                            --server-name 10.20.152.72 \
                            --model-name model2 \
                            --cache-max-entry-count 0.01 \
                            --server-port 8001