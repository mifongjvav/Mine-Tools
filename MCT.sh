#!/bin/bash

# 输出欢迎信息
echo "欢迎使用 Minecraft 工具脚本！"

# 输出脚本启动的时间
echo "脚本启动时间: $(date)"

# 显示分隔线
echo "------------------------"

# 提示用户输入运行模式
echo "请选择运行模式："
echo "1. 运行工具"
echo "2. 运行注册工具程序"
read -p "请输入数字 (1 或 2): " mode

# 根据用户输入执行相应操作
if [ "$mode" == "1" ]; then
    # 如果输入1则运行以下代码
    # 读取 tools/!tools.txt 里面的内容，并输出
    if [ -f "tools/!tools.txt" ]; then
    echo "工具列表:"
    grep -o '^[^#]*' "tools/!tools.txt"  # 过滤掉 # 及其后面的内容
    else
    echo "错误: tools/!tools.txt 文件未找到。"
fi

# 提示用户请输入工具昵称（不需要扩展名）
read -p "请输入工具昵称（不需要扩展名）: " tool_name

# 设置变量 file 为 tools/功能序号和.sh合并
file="tools/${tool_name}.sh"

# 检查文件是否存在
if [ -f "$file" ]; then
    bash "$file"
else
    echo "杂鱼～下载时都不带脑子的吗，此项不存在，找不到了哦～"
fi
    # 在这里添加要运行的代码
elif [ "$mode" == "2" ]; then
    # 如果输入2则打开 !AT.sh
    if [ -f "tools/!AT.sh" ]; then
        bash tools/!AT.sh
    else
        echo "无法启动"
        exit
    fi
else
    echo "无效的输入，请输入 1 或 2。"
fi
