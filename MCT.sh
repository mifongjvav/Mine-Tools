#!/bin/bash

# 加载语言文件
# 参数：$1 语言文件名（不需要扩展名）
load_language_file() {
    local lang_file="lang/$1.lang"  # 语言文件路径
    if [ -f "$lang_file" ]; then  # 检查语言文件是否存在
        # 逐行读取语言文件
        while IFS='=' read -r key value; do
            # 忽略空行和注释行（以 # 开头的行）
            if [[ ! -z "$key" && ! "$key" =~ ^"#" ]]; then
                # 去掉 value 中的注释部分（# 及其后面的内容）
                value=$(echo "$value" | cut -d'#' -f1 | xargs)
                # 将键值对赋值给变量
                eval "$key=\"$value\""
            fi
        done < "$lang_file"
    else
        echo "错误: 语言文件 $lang_file 未找到。"
        return 1  # 返回错误状态
    fi
}

# 初始化默认语言
initialize_language() {
    if [ ! -f "!SET.txt" ]; then  # 检查是否是第一次运行
        echo "首次运行，请输入语言文件名（不需要扩展名，例如 zh_cn 或 en_us）："
        read -p "请输入语言文件名: " lang_file  # 提示用户输入语言文件名
        if load_language_file "$lang_file"; then  # 尝试加载语言文件
            language="$lang_file"  # 设置当前语言
            echo "language:$language" > !SET.txt  # 将语言设置保存到 !SET.txt
            echo "语言设置已保存。"
        else
            echo "无法加载语言文件，默认使用 zh_cn。"
            language="zh_cn"  # 如果加载失败，默认使用 zh_cn
            load_language_file "$language"  # 加载默认语言文件
        fi
    else
        # 从 !SET.txt 中读取语言设置，忽略以 # 开头的行
        language=$(grep -v '^#' !SET.txt | grep 'language:' | cut -d':' -f2)
        if [ -z "$language" ] || ! load_language_file "$language"; then  # 检查语言设置是否有效
            echo "未找到有效的语言设置，默认使用 zh_cn。"
            language="zh_cn"  # 如果无效，默认使用 zh_cn
            load_language_file "$language"  # 加载默认语言文件
        fi
    fi
}

# 初始化语言
initialize_language

# 输出欢迎信息
echo "$welcome_message"

# 输出脚本启动的时间
echo "$script_start_time $(date)"

# 显示分隔线
echo "$separator"

# 提示用户输入运行模式
echo "$mode_selection_prompt"
echo "$mode_option_1"
echo "$mode_option_2"
echo "$mode_option_3"
echo "$mode_option_4"
echo "$exit"
read -p "$enter_tool_number_prompt" mode  # 读取用户输入的模式

# 根据用户输入执行相应操作
if [ "$mode" == "1" ]; then  # 模式 1：列出并运行工具
    echo "$tool_list_prompt"

    if [ -f "tools/!tools.txt" ]; then  # 检查工具列表文件是否存在
        grep -o '^[^#]*' "tools/!tools.txt"  # 列出可用的工具（忽略注释行）
    else
        echo "$file_not_found_error"  # 如果文件不存在，显示错误信息
    fi

    read -p "$enter_tool_name_prompt" tool_name  # 提示用户输入工具名称

    file="tools/${tool_name}.sh"  # 工具脚本路径

    if [ -f "$file" ]; then  # 检查工具脚本是否存在
        bash "$file"  # 执行工具脚本
    else
        echo "$tool_not_found_error"  # 如果工具不存在，显示错误信息
    fi
elif [ "$mode" == "2" ]; then  # 模式 2：运行 AT 工具
    if [ -f "tools/!AT.sh" ]; then  # 检查 AT 工具脚本是否存在
        bash tools/!AT.sh  # 执行 AT 工具脚本
    else
        echo "$failed_to_start_error"  # 如果脚本不存在，显示错误信息
        exit  # 退出脚本
    fi
elif [ "$mode" == "3" ]; then  # 模式 3：运行 DFW 工具
    if [ -f "tools/!DFW.sh" ]; then  # 检查 DFW 工具脚本是否存在
        bash tools/!DFW.sh  # 执行 DFW 工具脚本
    else
        echo "$failed_to_start_error"  # 如果脚本不存在，显示错误信息
        exit  # 退出脚本
    fi
elif [ "$mode" == "4" ]; then  # 模式 4：更改语言
    read -p "$change_language_prompt" lang_file  # 提示用户输入新的语言文件名
    if load_language_file "$lang_file"; then  # 尝试加载新的语言文件
        language="$lang_file"  # 更新当前语言
        echo "language:$language" > !SET.txt  # 将新的语言设置保存到 !SET.txt
        echo "$language_set_saved"  # 提示语言设置已保存
    else
        echo "无法加载语言文件，当前语言保持不变。"  # 如果加载失败，提示用户
    fi
elif [ "$mode" == "5" ]; then  # 模式 5：退出脚本
    echo "$exit_yes"  # 提示用户正在退出
    exit  # 退出脚本
else
    echo "$invalid_input_prompt"  # 如果输入无效，提示用户
fi