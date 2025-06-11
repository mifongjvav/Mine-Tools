#!/bin/bash
# MT.sh - 主程序入口
# 版本: 4.2
# 许可证: MIT

source MT_C11_library.sh || {
    echo "错误：无法正确引入C11库" >&2
    exit 1
}

# 检查并显示公告（修复版）
if check_notice; then
    show_notice
fi

main_menu