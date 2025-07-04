# Mine Tools 脚本浏览器

## 概述

Mine Tools 是一个模块化的 Bash 脚本浏览器，提供不错的工具浏览功能。该项目包含：

1. **主程序 (MT.sh)** - 提供用户界面和核心功能
2. **基础支持库 (MT_C11_library.sh)** - 提供通用功能和 API
3. **配置文件 (MT_CFG_library.sh)** -所有变量的位置
4. **DFW 下载器工具 (!DFW.sh)** - 从 GitHub 下载仓库并解压工具
And 3 default tools.
And more...

## 主要功能

### 1. 主程序功能 (MT.sh)

- **工具浏览模式**：
  - 以树状结构浏览 `tools` 目录
  - 显示目录(📁)和脚本文件(📄)
  - 支持返回上级目录
  - 自动排除以 `!` 开头的系统脚本

- **主菜单**：
  - 运行工具
  - 运行DFW下载器
  - 退出程序

### 2. 基础支持库 (MT_C11_library.sh)

- **配置文件**
 - 所有变量存储在配置文件中，更方便修改

- **公告系统**：
  - 每 24 小时检查一次公告更新
  - 从指定 URL 下载公告
  - 显示新公告内容

- **目录浏览功能**：
  - 生成目录和文件列表
  - 管理浏览路径堆栈
  - 处理用户选择


### 3. DFW 下载器功能 (!DFW.sh)

> 此工具用于从 GitHub 下载仓库并解压到工具目录

- **主要特性**：
  - 从 GitHub 下载仓库压缩包
  - 支持 zip 格式
  - 自动解压到 `tools` 目录
  - 创建仓库名的子目录
  - 清理临时文件

- **工作流程**：
  1. 用户输入 GitHub 仓库 URL 或作者/仓库名
  2. 下载仓库压缩包（默认分支）
  3. 解压到 `tools/仓库名` 目录
  4. 清理下载的临时文件

## 使用说明

### 如何下载

在终端输入
   ```bash
   git clone https://github.com/mifongjvav/Mine-Tools.git
   ```
* 需要你的设备安装了git

或者下载仓库自己解压

### 基本操作

1. 运行主程序

2. 主菜单选项：
   - **1. 运行工具**：浏览和执行工具脚本
   - **2. 运行DFW下载器**：下载 GitHub 仓库工具
   - **3. 退出**

### 工具目录结构

```
tools/
  ├── !DFW.sh       # 系统工具 (以 ! 开头)
  └你安装的工具昵称.sh      #你安装的工具
```

### DFW 下载器使用示例

1. 在主菜单中选择 "2. 运行DFW下载器"
2. 输入 GitHub 作者/仓库名and分支：
   ```
    输入 作者/仓库名 (如: mifongjvav/Mine-Tools):
    输入分支名 (如: main):
   ```
3. 等待下载和解压完成
4. 新工具将出现在 `tools` 目录下

## 技术特点

- **模块化设计**：主程序与库分离，便于维护
- **兼容性**：使用 curl 替代 wget 增强兼容性
- **用户友好**：彩色公告显示，清晰菜单结构

## 系统要求

- Bash 4.0+
- curl
- 基本 UNIX 工具 (find, sort, cmp 等)

## 许可证

MIT LICENSE
