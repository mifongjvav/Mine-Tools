#!/bin/bash
# !DFW.sh - GitHub 仓库下载器

#######################################
# 配置区（可修改）
#######################################
GITHUB_DOWNLOAD_URL="https://github.com/{author}/{repo}/archive/refs/heads/{branch}.zip"
TEMP_DIR=".dfw_temp"
INSTALL_DIR="tools"

#######################################
# 主功能
#######################################

show_help() {
    clear
    echo "=== GitHub 仓库下载器帮助 ==="
    echo "1. 下载说明："
    echo "   - 输入格式：作者/仓库名"
    echo "   - 示例：mifongjvav/Mine-Tools"
    echo "2. 分支说明："
    echo "   - 通常使用 main 或 master"
    echo "   - 示例：main"
    echo "3. 下载内容："
    echo "   - 会自动解压到 tools/ 目录"
    echo "   - 保留原始目录结构"
    read -p "按回车键返回主菜单..." dummy
}

cleanup() {
    rm -rf "$TEMP_DIR" 2>/dev/null
}

download_repo() {
    local author_repo=$1
    local branch=$2

    # 验证输入格式
    if [[ ! "$author_repo" =~ ^[^/]+/[^/]+$ ]]; then
        echo "错误：请输入 作者/仓库名 的格式"
        return 1
    fi

    local author=${author_repo%/*}
    local repo=${author_repo#*/}

    # 构建下载URL
    local download_url="${GITHUB_DOWNLOAD_URL//\{author\}/$author}"
    download_url="${download_url//\{repo\}/$repo}"
    download_url="${download_url//\{branch\}/$branch}"
    
    mkdir -p "$TEMP_DIR" || {
        echo "错误：无法创建临时目录"
        return 1
    }

    echo "正在下载 $author/$repo ($branch)..."
    if ! wget --show-progress -q "$download_url" -O "$TEMP_DIR/repo.zip"; then
        echo "下载失败，请检查："
        echo "1. 仓库是否存在"
        echo "2. 分支名称是否正确"
        return 1
    fi

    echo "正在解压..."
    if ! unzip -q "$TEMP_DIR/repo.zip" -d "$TEMP_DIR"; then
        echo "解压失败，文件可能已损坏"
        return 1
    fi

    local extracted_dir="$TEMP_DIR/${repo}-${branch}"
    if [ ! -d "$extracted_dir" ]; then
        echo "错误：解压后目录结构不符合预期"
        return 1
    fi

    echo "正在安装到 $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR"
    cp -r "$extracted_dir"/* "$INSTALL_DIR"/
    chmod -R +x "$INSTALL_DIR"/*.sh 2>/dev/null

    cleanup
    echo "安装成功！脚本已保存到 $INSTALL_DIR 目录"
    read -p "按回车键返回主菜单..." dummy
}

#######################################
# 用户界面
#######################################

main_menu() {
    while true; do
        clear
        echo "=== GitHub 仓库下载器 ==="
        echo "1. 下载仓库"
        echo "2. 查看帮助"
        echo "3. 退出"

        read -p "请选择操作: " choice

        case "$choice" in
            1)
                read -p "输入 作者/仓库名 (如: mifongjvav/Mine-Tools): " author_repo
                read -p "输入分支名 (如: main): " branch
                download_repo "$author_repo" "$branch"
                ;;
            2)
                show_help
                ;;
            3)
                cleanup
                exit 0
                ;;
            *)
                echo "无效选择，请重新输入"
                sleep 1
                ;;
        esac
    done
}

# 启动主菜单
main_menu