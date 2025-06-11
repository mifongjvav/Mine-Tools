#!/bin/bash
# MTUpdater.sh - MineTools Updater

#######################################
# 配置区
#######################################
AUTHOR="mifongjvav"
REPO="Mine-Tools"
MAIN_BRANCH="main"
OF_BRANCH="OF"
DEFAULT_DIR="./"
TEMP_DIR=".mt_temp"
MAIN_SCRIPT="MT.sh"

#######################################
# 欢迎界面
#######################################
show_welcome() {
    clear
    echo "===================================="
    echo "      MineTools Updater       "
    echo "===================================="
    read -p "按回车键开始..." dummy
}

#######################################
# 清理临时文件
#######################################
cleanup() {
    rm -rf "$TEMP_DIR" 2>/dev/null
}

#######################################
# 安装主程序
#######################################
install_main() {
    local install_dir=$1
    local download_url="https://github.com/$AUTHOR/$REPO/archive/refs/heads/$MAIN_BRANCH.zip"
    
    echo "正在更新主程序..."
    wget -q --progress=bar:force "$download_url" -O "$TEMP_DIR/main.zip" || {
        echo "错误：主程序下载失败"
        return 1
    }
    
    echo "解压主程序..."
    unzip -oq "$TEMP_DIR/main.zip" -d "$TEMP_DIR"
    cp -rf "$TEMP_DIR/${REPO}-${MAIN_BRANCH}/"* "$install_dir/"
}

#######################################
# 运行主脚本（修复版）
#######################################
run_main_script() {
    local install_dir=$1
    
    # 检查脚本是否存在
    if [ ! -f "$install_dir/$MAIN_SCRIPT" ]; then
        echo "错误：未找到主脚本 $MAIN_SCRIPT"
        return 1
    fi
    
    # 检查临时执行路径
    local temp_exec=""
    if [ -f "$install_dir/.temp_exec_path" ]; then
        temp_exec=$(cat "$install_dir/.temp_exec_path")
    fi
    
    echo -e "\n正在启动 $MAIN_SCRIPT ..."
    
    # 尝试三种执行方式
    if [ -n "$temp_exec" ] && [ -x "$temp_exec" ]; then
        (cd "$(dirname "$temp_exec")" && exec "$temp_exec")
    elif [ -x "$install_dir/$MAIN_SCRIPT" ]; then
        (cd "$install_dir" && exec "./$MAIN_SCRIPT")
    else
        (cd "$install_dir" && sh "./$MAIN_SCRIPT")
    fi
    
    # 清理临时文件
    [ -n "$temp_exec" ] && rm -f "$temp_exec" "$install_dir/.temp_exec_path"
}
 
#######################################
# 主流程
#######################################
main() {
    mkdir -p "$TEMP_DIR"
    show_welcome
    
    # 安装主程序
    install_main "$install_dir" || {
        cleanup
        exit 1
    }
            
    # 安装后处理
    
    echo "更新完毕！请手动运行！"
    
    cleanup
}

trap cleanup EXIT
main