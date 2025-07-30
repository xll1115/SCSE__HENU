#从landchain_openai模块导入ChatOpenAI类
from langchain_openai import ChatOpenAI


#创建一个ChatOpenAI实例，用于大语言模型交互
llm = ChatOpenAI(
    model_name="deepseek-chat",
    openai_api_base="https://api.deepseek.com",
    openai_api_key="sk-f4fb13e2d804489696368d53285b3646",
    streaming=True,
    model_kwargs={
        "stop": ["Observation:", "Observation:\n"]
    },
    temperature=0
)


query = 'What are the top 3 most popular programming languages in 2023?'
c=llm.predict(query)

print(c)