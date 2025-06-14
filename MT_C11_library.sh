#!/bin/bash
# MT_C11_library - 脚本基本支持库C11 API
# 版本: 4.2
# 许可证: MIT

source MT_CFG_library.sh || {
    echo "错误：无法正确引入C11库前置CFG库" >&2
    exit 1
}

check_notice() {
    # 24小时内不重复检查
    local current_time=$(date +%s)
    local last_check=0
    [ -f "$LAST_CHECK_FILE" ] && last_check=$(cat "$LAST_CHECK_FILE")
    (( current_time - last_check < 86400 )) && return 1

    echo $current_time > "$LAST_CHECK_FILE"
    
    # 使用curl替代wget增强兼容性
    if curl -s --connect-timeout 5 "$NOTICE_URL" -o "$NOTICE_FILE.new"; then
        if [ -s "$NOTICE_FILE.new" ]; then
            # 比较新旧公告内容
            if [ ! -f "$NOTICE_FILE" ] || ! cmp -s "$NOTICE_FILE" "$NOTICE_FILE.new"; then
                mv "$NOTICE_FILE.new" "$NOTICE_FILE"
                return 0
            fi
        fi
    fi
    rm -f "$NOTICE_FILE.new"
    return 1
}

show_notice() {
    [ ! -f "$NOTICE_FILE" ] && return
    clear
    echo -e "\033[44m=== 系统公告 ===\033[0m"
    cat "$NOTICE_FILE"
    echo -e "\033[44m================\033[0m"
    read -p "按回车键继续..." dummy
    rm -f "$NOTICE_FILE"
}

generate_dir_list() {
    CURRENT_ITEMS=()
    local counter=1
    
    # 返回上级选项
    [ "$CURRENT_BROWSE_PATH" != "$CURRENT_BROWSE_PATH" ] && echo "0. ↩ 返回上级"

    # 先显示目录
    while IFS= read -r dir; do
        echo "$counter. $FOLDER $(basename "$dir")"
        CURRENT_ITEMS+=("$dir")
        ((counter++))
    done < <(find "$CURRENT_BROWSE_PATH" -maxdepth 1 -mindepth 1 -type d | sort)

    # 再显示脚本文件（排除!开头的系统脚本）
    while IFS= read -r file; do
        local name=$(basename "$file" .sh)
        echo "$counter. $FILE $name"
        CURRENT_ITEMS+=("$file")
        ((counter++))
    done < <(find "$CURRENT_BROWSE_PATH" -maxdepth 1 -mindepth 1 -type f -name "$FE" ! -name "$L2F" | sort)
}

handle_selection() {
    local choice="$1"
    
    case $choice in
        0)
            [ ${#PATH_STACK[@]} -gt 0 ] && {
                CURRENT_BROWSE_PATH="${PATH_STACK[-1]}"
                unset 'PATH_STACK[${#PATH_STACK[@]}-1]'
            }
            ;;
        *)
            local index=$((choice-1))
            if (( index >= 0 && index < ${#CURRENT_ITEMS[@]} )); then
                if [ -d "${CURRENT_ITEMS[$index]}" ]; then
                    PATH_STACK+=("$CURRENT_BROWSE_PATH")
                    CURRENT_BROWSE_PATH="${CURRENT_ITEMS[$index]}"
                else
                    bash "${CURRENT_ITEMS[$index]}"
                    return 2
                fi
            else
                echo "无效选择！"
                return 1
            fi
            ;;
    esac
    return 0
}

#######################################
# 初始化
#######################################
mkdir -p "$CURRENT_BROWSE_PATH"

run_tool_mode() {
    local ret=0
    while true; do
        clear
        echo "=== 浏览目录: ${CURRENT_BROWSE_PATH/$CURRENT_BROWSE_PATH\//} ==="
        
        generate_dir_list
        echo "----------------------"
        echo "x. 返回主菜单"
        
        read -p "请选择: " choice
        
        case "$choice" in
            x) 
                CURRENT_BROWSE_PATH="$CURRENT_BROWSE_PATH"
                PATH_STACK=()
                return
                ;;
            *)
                if [[ "$choice" =~ ^[0-9]+$ ]]; then
                    handle_selection "$choice"
                    ret=$?
                    [ $ret -eq 2 ] && read -p "按回车键返回..."
                else
                    echo "无效输入"
                    sleep 1
                fi
                ;;
        esac
    done
}

main_menu() {
    while true; do
        clear
        echo "=== Mine Tools 4.2 ==="
        echo "1. 运行工具"
        echo "2. 运行DFW下载器"
        echo "3. 退出"
        
        read -p "请选择: " choice
        case "$choice" in
            1) run_tool_mode ;;
            2) bash "$CURRENT_BROWSE_PATH/!DFW.sh" ;;
            3) 
                echo "See you next time!"
                exit 0
                ;;
            *) 
                echo "无效选择"
                sleep 1
                ;;
        esac
    done
}