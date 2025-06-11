#!/bin/bash
# MT_CFG_library.sh - C11库的配置文件
# 版本: 4.2
# 许可证: MIT

#######################################
# 初始化配置
#######################################
declare -g SCRIPT_URL="./MTUpdater.sh" #更新脚本位置
declare -g FE="*.sh" #显示的文件类型
declare -g L2F="!*" #重要脚本前缀
declare -g FOLDER="📁" #文件夹图标
declare -g FILE="📄" #文件图标
declare -g UPDATE_TIMEOUT=15 #更新超时时间（s）

#######################################
# 公告系统（已修复）
#######################################
declare -g NOTICE_FILE=".notice_cache" #公告缓存名字
declare -g NOTICE_URL="https://mifongjvav.github.io/公告.txt" #公告URL
declare -g LAST_CHECK_FILE=".last_notice_check" #时间戳保存文件

#######################################
# 目录浏览功能（纯净版）
#######################################
declare -g CURRENT_BROWSE_PATH="/storage/emulated/0/" #访问的目录
declare -g -a CURRENT_ITEMS=() #当前项目