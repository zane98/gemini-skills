---
name: gemini-image
description: 使用 Gemini 生成图片并自动保存到本地。用法：/gemini-image <描述> [--size 1024x1024] [--dir ~/Pictures/gemini-images]
---

# Gemini Image

生成图片并自动保存为本地文件，返回文件路径。

## 参数

- `--size`：图片尺寸，如 `512x512`、`1024x1024`、`4096x4096`，默认 `1024x1024`
- `--dir`：保存目录，默认 `~/Pictures/gemini-images`

## 步骤

1. 从用户输入提取图片描述、`--size`、`--dir` 参数

2. 用 Python 调用 API 并保存图片：

```python
import json, urllib.request, subprocess, base64, re
from datetime import datetime
from pathlib import Path

api_key = subprocess.check_output(
    "grep 'GEMINI_API_KEY' ~/.zshrc | head -1 | cut -d'\"' -f2",
    shell=True
).decode().strip()

prompt = "<图片描述>"
size = "<尺寸，默认1024x1024>"
save_dir = Path("<保存目录，默认~/Pictures/gemini-images>").expanduser()
save_dir.mkdir(parents=True, exist_ok=True)

payload = {
    "model": "Nano-Banana-2",
    "messages": [{"role": "user", "content": prompt}],
    "size": size
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
content = data["choices"][0]["message"]["content"]

match = re.search(r'data:image/(jpeg|png|gif|webp);base64,([A-Za-z0-9+/=]+)', content)
if match:
    ext = "jpg" if match.group(1) == "jpeg" else match.group(1)
    img_data = base64.b64decode(match.group(2))
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filepath = save_dir / f"gemini_{timestamp}.{ext}"
    filepath.write_bytes(img_data)
    print(f"Image saved to: {filepath}")
else:
    print(content)
```

3. 输出图片保存路径，供用户用 `open <路径>` 查看
