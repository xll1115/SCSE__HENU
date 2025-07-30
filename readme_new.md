-----

## SCSE（Smart Campus Super Entrance）智慧校园的超级入口 - 河南大学定制版

\<div align=center\>\<img src="/assets/logo\_hnu.png" alt="河南大学SCSE标志"\>\</div\>

### 📖 项目介绍

　　当前，各大高校普遍面临信息分散于不同部门门户、形成“信息孤岛”的挑战。河南大学的师生们也迫切需要一个统一、高效的智能问答入口，来便捷地查询涉及财务处、人事处、学工处、教务处、图书馆等众多部门的政策文件和活动信息。传统的基于知识图谱的问答系统，在面对新知识的自适应更新和复杂推理方面往往表现出局限性。针对河南大学的实际需求，本项目基于先进的校园大模型技术，设计并研发了一套**河南大学智慧校园智能问答系统**，旨在为全校师生建立一个统一、高效的信息获取与交互平台。

　　本项目深度定制，**基座模型**采用**InternLM2.5-chat-7b** :boom:，确保了通用问答的卓越性能。针对师生心理健康需求，**心理模型**选用**InternLM2-chat-1.8b**并通过**Xtuner**进行SFT微调，使其高度适应河南大学校园特有的情感交互场景。为保证系统流畅运行，部署集成了 **LMDeploy加速推理** 🚀。功能上，系统全面支持 **ASR 语音生成文字(Whisper)** 🎙️和**TTS 文字转语音(Edge-TTS)** 🔊，实现了自然流畅的人机语音交互。核心的 **RAG 检索增强生成** :floppy\_disk:模块，能够精准融合多源信息，有效解决了信息孤岛问题。此外，系统内置 **Agent（ReAct范式）** :wrench:，赋予大模型调用外部工具的能力，极大拓展了服务边界。为提升用户体验，我们还集成了**数字人** :hear\_no\_evil:，能根据聊天情境动态变化肢体状态。更具河南大学特色的是，我们利用**知识图谱可视化**功能，创新性地开发了**闯关式学习功能** :satisfied:，旨在以互动有趣的方式，帮助师生更好地了解和掌握校园知识。

　　本项目的目标是为河南大学打造一个真正智能、便捷、有温度的校园信息服务超级入口，赋能师生智慧校园生活。

### 🛠 技术架构

#### 河南大学心理大模型数据集构建与微调(Fine-tune)

本项目借鉴[EmoLLM](https://github.com/SmartFlowAI/EmoLLM/blob/main/generate_data/tutorial.md)的经验，结合河南大学师生心理特点和校园实际情境，构建了定制化的心理微调数据集。数据集已整合至 `ft_datasets` 文件夹下，以确保模型能更精准地理解和回应本校师生的情感需求。

微调工具选用[Xtuner](https://github.com/InternLM/xtuner)，并采用 **Qlora** 方法高效构建新模型，以在有限资源下达到最佳微调效果。项目同样支持通过[LMDeploy](https://github.com/InternLM/LMDeploy)直接接入现有心理类LLM，为后续迭代提供灵活性。

#### RAG 检索增强生成 - 河南大学知识库定制

目前已开源部分适用于河南大学的PDF和TXT文件样例。

  * **针对普通PDF文件**：本项目通过使用 [Doc2X](https://doc2x.noedgeai.com/) 工具，将河南大学的各类规章制度、办事流程等PDF文件高效转换为**Markdown结构化文件**。经过严格测试，这种结构化处理显著提升了召回效果和信息检索的精准性。
  * **针对TXT文件**：考虑到TXT内容通常较为精炼，我们直接采用传统的`chunk`方法进行分块和`embedding`存储，以确保快速检索。
  * **针对河南大学特定课程文件（如模式识别）**：我们构建了专属的**知识图谱（KG）与向量数据库**，通过**混合检索**机制，共同回答专业性问题，确保了信息来源的权威性和回答的全面性。

#### Agent - 河南大学服务智能体

Agent功能基于[ReAct](https://arxiv.org/abs/2210.03629)范式实现，其核心在于整合**推理与行动**的能力，以增强模型在解决复杂校园任务时的效能：

  * **推理(Reasoning)**：此部分专注于模型的生成推理能力。借助链式思考（Chain-of-Thought）等高级提示技术，促使模型在执行任务时能进行更深入的逻辑推理。这使得模型在决策过程中能更有效地跟踪和更新自身的行动策略，并灵活应对河南大学校园生活中可能遇到的各种异常情况。
  * **行动(Acting)**：此部分强调模型执行具体行动的能力，允许模型与外部资源（如河南大学校内系统、各部门信息门户等）互动，从而获取额外信息或执行特定操作。在ReAct框架下，行动概念扩展至模型与校园外部世界的广泛行为，包括信息检索、执行特定任务步骤（如查询教务信息、办理财务手续、预订图书馆资源等），充分展现了模型在与校园环境互动时的动态能力和灵活性。

#### TTS 文字转语音 - 河南大学音色优化

TTS是一种将文本信息转换成语音输出的技术。在本项目中初步采用[edge-tts](https://kkgithub.com/rany2/edge-tts)，并积极挑选与优化，力求找到**最适合河南大学师生听感的良好音色**，用于将LLM的输出文本转换成语音内容，提供亲切自然的听觉体验。后续将尝试接入其他更先进的TTS模型（例如GPT-SoVITS）进行再次开发，以达到更优质的语音合成效果。

#### ASR 语音转文字 - 河南大学语音环境适应性

ASR是一种将用户的语音输入转换成文本信息输出的技术。本项目初步采用[Whisper](https://github.com/openai/whisper)模型，该模型在通用语音识别方面表现优异。鉴于河南大学校园内部可能存在的口音或特定词汇，后续将考虑接入并优化其他ASR模型（例如FunASR），以提升其在河南大学**特定语音环境下的识别准确率和适应性**。

#### 数字人 - 河南大学形象与互动体验

数字人技术旨在通过虚拟形象与用户进行互动，显著增强用户体验感。本项目基于three.js将一个glb模型加载到Web页面上，目前该数字人模型支持**休闲状态、用户输入时的观望动作和聊天状态**三种基础动作。未来，我们将尝试引入更多符合河南大学文化特色和师生喜好的数字人模型，并开发更丰富的动作库，甚至探索结合其他先进数字人技术，以期打造一个更具互动性和沉浸感的智慧校园入口。

### 📺️ 讲解视频

[scse-基于llm的智慧校园超级入口](https://www.bilibili.com/video/BV1vHYFeeEN6/) - *（注意：此视频为通用项目讲解，河南大学定制版特性将在后续展示）*

### 🎯 使用指南

**配置项目环境**

```
git clone [https://github.com/your_github_id/SCSE-HNU.git](https://github.com/your_github_id/SCSE-HNU.git) # 替换为您的实际仓库地址
conda create -n SCSE_HNU python=3.10 -y
conda activate SCSE_HNU
pip install -r requirements.txt
```

**配置项目变量**

```
请根据河南大学实际情况，修改config.yml中的各项变量为自己的实际所需，包括模型路径、数据库连接等。
```

**配置MySQL环境**

```
MySQL文件已包含在mysql文件夹中，请按照常规流程在Navicat等数据库管理工具中导入。
```

**构建Neo4j数据库**

```
cd SCSE_HNU/data/kg_data
python build_graph.py # 此脚本将根据河南大学的结构化数据构建知识图谱
```

**构建向量数据库**

```
cd SCSE_HNU/dealFiles
python common_files.py # 处理河南大学通用文档
python images_files.py # 处理河南大学特色图片
python pr_files.py # 处理河南大学模式识别课程文件（若有）
```

**启动模型**（需要自行配备好lmdeploy环境）

```
# 基座模型使用Internlm2_5-chat-7b-int4（需要使用lmdeploy进行量化）
lmdeploy serve api_server your_main_llm_path_hnu # 替换为河南大学定制基座模型路径
                            --server-name 127.0.0.1
                            --model-name Internlm2_5-chat-7b-int4
                            --cache-max-entry-count 0.01
                            --server-port 8000
# 心理聊天模型
lmdeploy serve api_server your_emo_llm_path_hnu # 替换为河南大学定制心理模型路径
                            --server-name 127.0.0.1
                            --model-name your_emo_llm_name_hnu
                            --cache-max-entry-count 0.01
                            --server-port 23333
```

**启动后端接口**

```
python qa_mysql.py
uvicorn main:app --host 127.0.0.1 --port 7091 --workers 1 --reload
```

**启动前端页面**

```
cd web_demo
npm install
npm run serve
```

默认登录账号为 `admin`，密码 `123456`。

### 💕 特别鸣谢

  - [InternLM](https://github.com/InternLM/InternLM)
  - [xtuner](https://github.com/InternLM/xtuner)
  - [LMDeploy](https://github.com/InternLM/LMDeploy)
  - [EmoLLM](https://github.com/SmartFlowAI/EmoLLM/blob/main/generate_data/tutorial.md)

衷心感谢上海人工智能实验室推出的书生·浦语大模型实战营，为本项目提供了宝贵的技术指导和强大的算力支持，使得河南大学的智慧校园建设得以顺利推进。

### 引用

如果本项目对您的工作有所帮助，请使用以下格式引用：

```
@misc{SCSE_HNU,
    title={SCSE: Smart Campus Super Entrance - Henan University Customization},
    author={Your Name/Team Name}, # 请替换为您的姓名或团队名称
    url={https://github.com/your_github_id/SCSE-HNU}, # 请替换为您的实际仓库地址
    year={2024}
}
```
