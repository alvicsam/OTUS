#!/bin/bash

forexit=`echo $0 | sed 's/\.\///'`

#By default this number is 100. System variable sysconf(_SC_CLK_TCK). If you are note sure you can find it out by runnig sysclocktck
frq=100
m=0

dec2bin () {
    for((num=$1;num;num/=2))
    do
        bin=$((num%2))$bin
    done
    printf %08d $bin
}

#Major number of a device can be found in /proc/devices
tty_name () {
    result=$(dec2bin $1)
    minor2=`echo $result | grep -Eo '.{8}$'`
    minor10=$((2#$minor2))
    major2=`echo $result | sed 's/.\{8\}$//'`
    major10=$((2#$major2))
    case $major10 in
	4)          major="tty";;
        5) 		major="/dev/tty";;
	136)        major="pts";;
        188)	major="ttyUSB";;
	*)          major="some_dev";;
    esac
    echo $major$minor10
}

proc_name () {
    pid=$1
    name=`cat /proc/$pid/status | grep Name|sed 's/Name\:\t//'`
    echo $name
}

proc_cmd () {
    pid=$1
    proc_name=$(proc_name $pid)
    cmd=`cat /proc/$pid/cmdline|tr "\0" " "|head -c 155`
    if [[ $cmd == ""  ]]; then
	cmd=$proc_name
    fi
    echo $cmd
}

#If the process has several spaces in the name we can find it out comparing number of spaces in /proc/pid/stat file. Usually it equals 51
test_name_w_space () {
    pid=$1
    good=51
    proc_spaces=`cat /proc/$pid/stat | grep -o ' ' | wc -l `
    result=$(($proc_spaces-$good))
    echo $result
}

proc_tty () {
    pid=$1
    spaces=$2
    n=$((7+$spaces))
    ttyn=`cat /proc/$pid/stat | awk -v n=$n '{print $n}'`
    if [[ $ttyn -eq 0 ]]; then
        proc_tty="?"
    else
	proc_tty=$(tty_name $ttyn)
    fi
    echo $proc_tty
}

proc_niceness () {
    pid=$1
    spaces=$2
    n=$((19+$spaces))
    proc_stat_nice=`cat /proc/$pid/stat | awk -v n=$n '{print $n}'`
    if [[ $proc_stat_nice -lt "-3" ]]; then
        proc_stat_nice="<"
    elif [[ $proc_stat_nice -gt 4 ]]; then
	proc_stat_nice="N"
    else
        proc_stat_nice=""
    fi
    echo $proc_stat_nice
}

proc_locked_mem () {
    pid=$1
    proc_stat_lmem=`cat /proc/$pid/status | grep VmLck | awk '{print $2}'`
    if [[ $proc_stat_lmem -ne 0  ]];then
	proc_stat_lmem="L"
    else
        proc_stat_lmem=""
    fi
    echo $proc_stat_lmem
}

proc_session_leader () {
    pid=$1
    spaces=$2
    n=$((6+$spaces))
    proc_stat_sid=`cat /proc/$pid/stat | awk -v n=$n '{print $n}'`
    if [[ $pid -eq $proc_stat_sid ]];then
        proc_stat_slead="s"
    else
        proc_stat_slead=""
    fi
    echo $proc_stat_slead
}

proc_mthreaded () {
    pid=$1
    proc_stat_mthr=`ls /proc/$pid/task/ | wc -l`
    if [[ $proc_stat_mthr -gt 1 ]]; then
        proc_stat_mthr="l"
    else
        proc_stat_mthr=""
    fi
    echo $proc_stat_mthr
}

proc_fg () {
    pid=$1
    spaces=$2
    n=$((8+$spaces))
    proc_stat_isfg=`cat /proc/$pid/stat | awk -v n=$n '{print $n}'`
    if [[ $proc_stat_isfg == "-1"  ]];then
        proc_stat_isfg=""
    else
        proc_stat_isfg="+"
    fi
    echo $proc_stat_isfg
}

proc_time () {
    pid=$1
    spaces=$2
    n=$((14+$spaces))
    m=$((15+$spaces))
    proc_utime=`cat /proc/$pid/stat | awk -v n=$n '{print $n}'`
    proc_stime=`cat /proc/$pid/stat | awk -v m=$m '{print $m}'`
    let proc_time=($proc_utime+$proc_stime)/$frq
    let proc_time_min=$proc_time/60
    let proc_time_sec=$proc_time%60
    if [[ $proc_time_sec -lt 10 ]]; then
        proc_time_sec="0$proc_time_sec"
    fi
    echo $proc_time_min:$proc_time_sec
}

echo -e "PID \t TTY \t\t STAT \t\t TIME \t \t COMMAND"
for pid in `ls /proc | grep -o '[0-9]*'|sort -n`
do
    if [ ! -e /proc/$pid/stat ];then
	continue
    fi
    spaces=$(test_name_w_space $pid)
    proc_name=$(proc_name $pid)
    proc_cmd=$(proc_cmd $pid)
    proc_tty=$(proc_tty $pid $spaces)
    proc_state=`cat /proc/$pid/status | grep State |awk '{print $2}'`
    proc_stat_nice=$(proc_niceness $pid $spaces)
    proc_stat_lmem=$(proc_locked_mem $pid)
    proc_stat_slead=$(proc_session_leader $pid $spaces)
    proc_stat_mthr=$(proc_mthreaded $pid)
    proc_stat_isfg=$(proc_fg $pid $spaces)
    proc_time=$(proc_time $pid $spaces)
    echo -e "$pid \t $proc_tty \t\t $proc_state$proc_stat_nice$proc_stat_lmem$proc_stat_slead$proc_stat_mthr$proc_stat_isfg \t\t $proc_time  \t\t $proc_cmd"
done


