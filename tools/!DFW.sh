#!/bin/bash

# 定义 !mtools.txt 的 URL
tools_url="https://mifongjvav.github.io/!mtools.txt"

# 下载 !mtools.txt 文件并读取内容
echo "正在下载工具列表..."
wget -q "$tools_url" -O !mtools.txt

# 检查文件是否下载成功
if [ -f "!mtools.txt" ]; then
    echo "工具列表:"
    # 过滤掉 # 及其后面的内容，并输出
    grep -o '^[^#]*' "!mtools.txt"
else
    echo "错误: !mtools.txt 文件下载失败。"
    exit 1
fi

# 询问用户输入工具昵称
read -p "输入工具昵称（并非序号）: " name
file="${name}.sh"

# 下载对应的工具脚本
echo "正在下载工具脚本: $file"
wget -q "https://mifongjvav.github.io/$file"

# 检查工具脚本是否下载成功
if [ -f "$file" ]; then
    echo "工具脚本下载成功: $file"
    # 创建 tools 文件夹（如果不存在）
    mkdir -p tools
    # 将下载的脚本移动到 tools 文件夹
    mv "$file" tools/
    echo "已将 $file 移动到 tools 文件夹。"
    echo "正在注册脚本..."
if [ -f "tools/$file" ]; then
    addname=$(sed -n '3p' "tools/$file")  # 获取文件的第三行
    addname=$(echo "$addname" | sed 's/^#//')  # 将开头的 # 替换为空格
else
    echo "错误: 文件 $file 未找到。"
    exit 1
fi

# 将 "变量name. addname" 写入 !tools.txt 的最后一行
if [ -f "tools/!tools.txt" ]; then
    echo "$name. $addname" >> "tools/!tools.txt"
    echo "已将 '$name. $addname' 写入 !tools.txt 的最后一行。"
else
    echo "错误: !tools.txt 文件未找到。"
fi
else
    echo "错误: 工具脚本 $file 下载失败。"
    exit 1
fi

# 清理下载的文件
rm -f !mtools.txt
echo "临时文件已清理。"