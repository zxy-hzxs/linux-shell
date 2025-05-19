#!/bin/bash

# Linux 一键巡检脚本
# 作者: liyb
# 生成时间: $(date)

LOG_FILE="/home/zhuxinyu/巡检报告_$(date +%F_%T).log"

# 初始化日志文件
echo "系统巡检报告" > $LOG_FILE
echo "生成时间: $(date)" >> $LOG_FILE


# 输出函数
log() {
    echo "$1" | tee -a $LOG_FILE
}

log ""
log ""
log "======================[1] 系统基本信息========================"
log "主机名: $(hostname)"
log "IP地址: $(hostname -I | cut -d' ' -f1)"
log "操作系统: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '\"')"
log "内核版本: $(uname -r)"
log "启动时间: $(uptime -s)"
log "运行时长: $(uptime -p)"
log "系统负载: $(uptime | awk -F'load average:' '{print $2}')"
log "当前时间: $(date)"
log ""

log "======================[2] CPU 信息==========================:"
log "CPU 型号: $(lscpu | grep 'Model name' | awk -F: '{print $2}' | sed 's/^ *//')"
log "逻辑CPU核数:  $(grep "processor" /proc/cpuinfo|sort -u|wc -l)"
log "物理CPU核数:  $(grep "physical id" /proc/cpuinfo |sort -u|wc -l)"
log "CPU 使用率: $(top -bn1 | grep '%Cpu' | awk '{print $2}')%"
log ""

log "======================[3] 内存使用情况=========================="
free -h | tee -a $LOG_FILE
log  "总共内存:  $(free -mh|awk "NR==2"|awk '{print $2}')"
log  "使用内存: $(free -mh|awk "NR==2"|awk '{print $3}')"
log  "剩余内存: $(free -mh|awk "NR==2"|awk '{print $7}')"
log  "内存使用占比:  $(free | grep -i mem |awk '{print $6/$2*100}'|cut -c1-5)"
log ""

log "======================[4] 磁盘使用情况=========================="
df -hT | tee -a $LOG_FILE
log ""

log "======================[5] 网络配置和连接=========================="
log "IP 地址: $(hostname -I)"
log "默认网关: $(ip route | grep default | awk '{print $3}')"
log "网络接口状态:"
ifconfig  | tee -a $LOG_FILE
log ""

log "网络连接状态:"
ss -tunlp | tee -a $LOG_FILE
log ""

log "======================[6] 服务状态检查=========================="

log "检查特定服务状态 (Firewalld，SSH，Nginx,，Apache,，MySQL):"
for service in firewalld sshd nginx apache2 mysqld; do
    if systemctl is-active --quiet $service; then
        log "$service 服务状态: 正在运行"
    else
        log "$service 服务状态: 未运行"
    fi
done
log ""

log "========================[7] 安全检查============================"
log "SSH 配置:"
grep -E "^#?PermitRootLogin|^#?PasswordAuthentication" /etc/ssh/sshd_config | tee -a $LOG_FILE
log ""


log "系统用户:"
awk -F: '{if ($3 >= 1000) print $1}' /etc/passwd | tee -a $LOG_FILE
log ""


log "========================[8] 登录记录============================"
log "当前登录用户:"
who | tee -a $LOG_FILE
log ""

log "最近登录记录:"
last -a | head -10 | tee -a $LOG_FILE
log ""

log "========================[9] 系统日志检查============================"
log "登录失败日志:"
grep "Failed password" /var/log/auth.log | tail -10 | tee -a $LOG_FILE || log "未检测到 auth.log 文件"
log ""

log "检查系统重启记录:"
last reboot | head -5 | tee -a $LOG_FILE
log ""


log "========================[10] 性能分析============================"
log "内存占用排行前5:"
ps aux --sort=-%mem | head -6 | tee -a $LOG_FILE
log ""

log "CPU 占用排行前5:"
ps aux --sort=-%cpu | head -6 | tee -a $LOG_FILE
log ""


log "=============================巡检完成============================"
log "巡检报告生成完成，保存路径: $LOG_FILE"
log "请根据巡检内容检查系统状态！"
log ""
