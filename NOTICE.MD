# Mine Tools 项目声明

## 一、核心文件版权

### 主程序
- **MT.sh**  
  © mifongjvav | [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0)

### 工具脚本
| 文件       | 功能描述                          | 授权协议                  |
|------------|----------------------------------|--------------------------|
| UME.sh     | 安全删除指定扩展名文件            | © mifongjvav             |
| !AT.sh     | 读取文件第三行写入工具列表        | [CC BY-NC-SA 3.0](https://creativecommons.org/licenses/by-nc-sa/3.0/) |
| !DFW.sh    | 下载管理工具脚本                  | [CC BY-NC-SA 3.0](https://creativecommons.org/licenses/by-nc-sa/3.0/) |
| 1.sh       | 超下界传送坐标计算                | © mifongjvav             |
| 2.sh       | 游戏时间(GT/RT/D)计算             | © mifongjvav             |
| 3.sh       | 重锤伤害值计算                    | © mifongjvav             |

## 二、第三方依赖

### 软件工具
- [wget](https://www.gnu.org/software/wget/) (GNU GPL)
- [unzip](http://infozip.sourceforge.net/) (Info-ZIP License)

### 内容引用
- [中文 Minecraft Wiki](https://zh.minecraft.wiki)  
  © 中文MC百科团队 | [CC BY-NC-SA 3.0](https://creativecommons.org/licenses/by-nc-sa/3.0/)  
  *注：仅!AT.sh/!DFW.sh包含衍生内容*

## 三、协议要点
1. **主程序**  
   - ✅ 允许商用/修改/专利使用  
   - ℹ️ 需保留版权声明

2. **Wiki衍生内容**  
   - ⚠️ 禁止商用 ([NC]条款)  
   - 🔗 修改需[署名](https://zh.minecraft.wiki)  
   - ♻️ 衍生作品需[相同方式共享](https://creativecommons.org/share-your-work/licensing-considerations/compatible-licenses)

## 四、UME.sh 特别说明
- **安全特性**：
  - 自动排除脚本自身目录
  - 双重确认防误删
  - 禁止删除.sh脚本文件
- **使用限制**：
  ```diff
  + 允许在企业内部使用
  - 禁止作为商业软件组件分发