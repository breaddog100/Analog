#!/bin/bash

function install_node() {
 
	#下载安装docker
	sudo snap install docker  
	
	#拉取时间链镜像
	sudo docker pull analoglabs/timechain
	
	#创建节点
	read -p "请输入节点名称:" nodevalue
	sudo docker run -d --network="host" --name analog -v home/ubuntu/analog_data analoglabs/timechain \
	--base-path /data \
	--rpc-external \
	--unsafe-rpc-external \
	--rpc-cors all \
	--name=$nodevalue \
	--rpc-methods Unsafe
  	
	echo "部署完成"
}
  
  
function view_status(){
	#查看docker运行情况
	sudo docker ps
}
  
function check_node_info(){
  #获取会话秘钥
  curl http://127.0.0.1:9944 -H \
"Content-Type:application/json;charset=utf-8" -d \
  '{
    "jsonrpc":"2.0",
    "id":1,
    "method":"author_rotateKeys",
    "params": []
  }'
}
  
  # 主菜单
function main_menu() {
	while true; do
	    clear
	    echo "===================analog 一键部署脚本==================="
		echo "沟通电报群：https://t.me/lumaogogogo"
		echo "推荐配置：8C16G300G"
	    echo "请选择要执行的操作:"
	    echo "1. 部署节点 install_node"
	    echo "2. 查看状态 view_status"
	    echo "3. 获取秘钥 check_node_info"
	    echo "0. 退出脚本 exit"
	    read -p "请输入选项: " OPTION
	
	    case $OPTION in
	    1) install_node ;;
	    2) view_status ;;
	    3) check_node_info ;;
	    0) echo "退出脚本。"; exit 0 ;;
	    *) echo "无效选项，请重新输入。"; sleep 3 ;;
	    esac
	    echo "按任意键返回主菜单..."
        read -n 1
    done
}

main_menu
