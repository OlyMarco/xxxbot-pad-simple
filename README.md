# 🤖 XXXBot-Pad-Simple 微信机器人项目 🤖

> ## ⚠️ 免责声明
>
> **本项目仅供学习交流使用，严禁用于商业用途！**
> 使用本项目所产生的一切法律责任和风险，由使用者自行承担，与项目作者无关。
> 请遵守相关法律法规，合法合规使用本项目。

## 📝 项目背景

本项目 fork 自 [XXXBot-Pad](https://github.com/NanSsye/xxxbot-pad)，由于 gewe 已停止更新，而 astrbot 暂时没有新的个人微信替代方案，因此基于 XXXBot 进行了精简和优化：

- ✅ 仅保留 849（iPad）协议登录方式，简化部署流程
- ✅ 增加 OpenAI 插件兼容系统提示词，支持自定义对话体验
- ✅ 优化一键启动脚本，支持 Windows 和 Linux 平台

## 🚀 快速开始

### 系统要求

- 🐍 Python 3.11+ (建议使用 Conda 虚拟环境)
- 🔋 Redis (Windows已包含在项目中，Linux需安装)
- 🎥 FFmpeg (如需语音功能)

### Windows 安装步骤

1. **克隆或下载项目**

2. **创建并激活 Conda 环境**
   ```bash
   conda create -n xxxbot python=3.11
   conda activate xxxbot
   ```

3. **安装依赖**
   ```bash
   pip install -r requirements.txt
   ```

4. **启动服务**
   - 直接运行 `start_simple.bat` 一键启动所有服务
   - 该脚本会自动启动 Redis、PAD 服务和主应用程序

### Linux 安装步骤

1. **克隆或下载项目**

2. **创建并激活 Conda 环境**
   ```bash
   conda create -n xxxbot python=3.11
   conda activate xxxbot
   ```

3. **安装依赖**
   ```bash
   pip install -r requirements.txt
   ```

4. **安装 screen**
   ```bash
   # Ubuntu/Debian
   sudo apt-get install screen

   # CentOS/RHEL
   sudo yum install screen
   ```

5. **如果 Redis 未安装，需要先安装**
   ```bash
   # Ubuntu/Debian
   sudo apt-get update
   sudo apt-get install redis-server

   # CentOS/RHEL
   sudo yum install redis
   ```

6. **赋予脚本执行权限**
   ```bash
   chmod +x entrypoint.sh exitpoint.sh
   ```

7. **启动与退出**
   ```bash
   # 启动所有服务
   ./entrypoint.sh
   
   # 退出所有服务
   ./exitpoint.sh
   ```

## 🔧 配置与使用

### 管理后台

- 🌐 访问地址：`http://127.0.0.1:9090`
- 👤 默认用户名：`admin`
- 🔑 默认密码：`admin1234`

### OpenAI 插件配置

1. 登录管理后台，选择"插件管理"
2. 找到 OpenAI API 插件，点击"配置"
3. 填入你的 OpenAI API Key 和其他相关设置
4. 可自定义系统提示词，优化对话效果

也可以直接编辑配置文件：
```
plugins\OpenAIAPI\config.toml
```

## 🎯 主要功能

- 💬 微信文本消息交互
- 📷 图片识别与处理
- 🎤 语音识别与回复
- 🧠 AI 对话能力
- 👥 群聊与私聊支持
- 🔌 插件扩展系统
- 💻 管理后台界面

## 💡 常见问题

1. **启动失败**
   - 确保 Redis 和 PAD 服务正常启动
   - 检查 Python 版本是否为 3.11+
   - 确认所有依赖已正确安装

2. **无法连接微信**
   - 确认 PAD 服务已正常运行
   - 检查网络连接和防火墙设置
   - 尝试重启所有服务

3. **OpenAI API 报错**
   - 验证 API 密钥是否正确
   - 确认网络可以访问 OpenAI 服务
   - 检查代理设置（如需使用）

## 📜 协议和许可

本项目基于 MIT 许可证 开源，您可以自由使用、修改和分发本项目的代码，但需保留原始版权声明。

### ⚠️ 重要免责声明

- **本项目仅供学习和研究使用，严禁用于任何商业用途**
- **使用前请确保符合微信和相关服务的使用条款**
- **使用本项目所产生的一切法律责任和风险，由使用者自行承担，与项目作者无关**
- **请遵守相关法律法规，合法合规使用本项目**
