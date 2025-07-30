

export CUDA_VISIBLE_DEVICES=1
# 基座模型使用Internlm2_5-chat-7b-int4(需要使用lmdepoly进行量化)
lmdeploy serve api_server  /home/zhaoyang/LLM_Weight/Qwen2-0.5B-Instruct \
                            --server-name 10.20.152.72 \
                            --model-name model1 \
                            --cache-max-entry-count 0.01 \
                            --server-port 8002 \
                            --tp 1



# 心理聊天模型                       
# lmdeploy serve api_server /home/zhaoyang/LLM_Weight/Qwen2-0.5B-Instruct \
#                             --server-name 10.20.152.72 \
#                             --model-name Qwen2.5-72B-Instruct-GPTQ-Int4 \
#                             --cache-max-entry-count 0.01 \
#                             --server-port 8001