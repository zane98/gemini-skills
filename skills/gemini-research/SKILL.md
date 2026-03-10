---
name: gemini-research
description: 使用 Gemini 实时联网调研，原文输出结果。用法：/gemini-research <查询内容> [--save 路径]
---

# Gemini Research

使用 Gemini Pro Search 模型进行实时联网调研，**原文输出，不加工、不总结、不改写**。

## 步骤

1. 从用户输入提取查询内容，以及可选的 `--save <path>` 参数

2. 用 Python 调用 API：

```python
import json, urllib.request, subprocess, sys

api_key = subprocess.check_output(
    "grep 'GEMINI_API_KEY' ~/.zshrc | head -1 | cut -d'\"' -f2",
    shell=True
).decode().strip()

query = "<用户查询内容>"

payload = {
    "model": "gemini-3.1-pro-preview-search",
    "messages": [
        {
            "role": "system",
            "content": "你是产品调研助手，请用中文回答，提供详细的分析和来源。如果涉及竞品分析，请列出关键对比维度。"
        },
        {"role": "user", "content": query}
    ]
}

req = urllib.request.Request(
    "https://api.devdove.site/v1/chat/completions",
    data=json.dumps(payload).encode(),
    headers={
        "Content-Type": "application/json",
        "Authorization": f"Bearer {api_key}"
    }
)
resp = urllib.request.urlopen(req, timeout=120)
data = json.loads(resp.read())
print(data["choices"][0]["message"]["content"])
```

3. **原文完整输出，不做任何加工**

4. 若有 `--save <path>`，将结果写入该路径（自动创建父目录）
