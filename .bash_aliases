alias ll='ls -l'
alias la='ls -lA'
alias l='ls -CF'
alias lr='ls -lR'
alias lar='ls -laR'
alias check='ping www.google.com'
alias THM='openvpn ~/THM/THEC4R3T4K3R.ovpn'
alias HTB='openvpn ~/HTB/TheCaretaker.ovpn'
alias VIP='openvpn ~/HTB/Phenomenal.ovpn'
alias END='openvpn ~/HTB/THEC4R3T4K3R-endgame.ovpn'
alias OFFSHORE='openvpn ~/HTB/eu-offshore-2-TheCaretaker.ovpn'
alias tun='ifconfig tun0 | grep "inet " | cut -d" " -f10'
alias cyberchef='firefox ~/Tools/CTF/CyberChef_v9.20.3.html'
alias stegsolve='java -jar ~/CTF/Tools/stegsolve.jar'
alias ghidra='/usr/local/bin/ghidra_10.0.4_PUBLIC/ghidraRun'
alias sl="if [ $((`date +%s`%2)) -eq 0 ]; then echo \''ls'\' not \''sl'\' you fool; else echo 'NOOB. Cant even type 😹'; fi"
alias tmux="tmux -u"
alias burp="burpsuite 1>&- 2>&- &"
#alias burpro="java -javaagent:/usr/local/bin/burp-pro/BurpSuiteLoader.jar -noverify -jar /usr/local/bin/burp-pro/burpsuite_pro.jar 1>&- 2>&- &"
#alias burpro="java --illegal-access=permit -Dfile.encoding=utf-8 -javaagent:/tmp/burp/Burp-Suite/loader.jar -noverify -jar /tmp/burp/Burp-Suite/Burp_Suite_Pro.jar &"
alias copy="head -c -1 | xclip -selection clipboard"
alias IP='grep -oE "([0-9]{1,3}\.){3}([0-9]){1,3}" /opt/.IP'
alias odat='export LD_LIBRARY_PATH=/opt/odat-libc2.12-x86_64;/opt/odat-libc2.12-x86_64/odat-libc2.12-x86_64'
alias ccat='highlight -O ansi'
#alias du='ncdu'
#alias cat='batcat'
#alias man='tldr'

##############################
# Color Codes \e ~ \033  # echo -e "${LightCyan}Hello ${Cyan}Hii ${NC}cool!"
Black='\e[0;30m'
DarkGray='\e[1;30m'
Red='\e[0;31m'
LightRed='\e[1;31m'
Green='\e[0;32m'
LightGreen='\e[1;32m'
Orange='\e[0;33m'
Yellow='\e[1;33m'
Blue='\e[0;34m' 
LightBlue='\e[1;34m'
Purple='\e[0;35m'
LightPurple='\e[1;35m'
Cyan='\e[0;36m'
LightCyan='\e[1;36m'
LightGray='\e[0;37m'   
White='\e[1;37m'
NC='\e[0m'

###### HTB VIP remaining hours and hours per machine
function htblist()
{
	finaldate="10 Oct 2021"
	file="/root/HTB/.list"
	machines="cat $file  | grep -v 'Click to Start' | tr ' ' '\n' |grep '[[:alpha:]]'| grep -vi 'windows\|linux\|freebsd\|image\|hours'"
	count=$(cat $file  | grep -v 'Click to Start' | tr ' ' '\n' |grep '[[:alpha:]]'| grep -vi 'windows\|linux\|freebsd\|image\|hours' | wc -l )

	echo 'Machines left:'; cat $file  | grep -v 'Click to Start' | tr ' ' '\n' |grep '[[:alpha:]]'| grep -vi 'windows\|linux\|freebsd\|image\|hours' | cat -n |grep '[[:alpha:]]' 
	echo -ne 'Hours left:\t\t' 
	echo \( $(date --date="$finaldate" +%s) - $(date +%s) \) / 3600 | bc -l
	echo -ne 'Hours per machine:\t' 
	echo  \( $(date --date="$finaldate" +%s) - $(date +%s) \) / 3600 / $count  | bc -l
	
}
function htbdone()
{
	if [ ! -z "$(cat ~/HTB/.list  | grep $1)" ]
	then
	sed -i -e "s/$1//g"  ~/HTB/.list
	echo $1 removed
	else echo 'Machine name not found!'
	fi

}

function plab()
{
	pcount=$(grep pcount ~/.plab | head -n1| cut -d '=' -f2)
    finaldate="20 April 2022"
	echo -ne 'Challenge left:\t\t'$pcount
    echo -ne '\nHours left:\t\t'
    echo \( $(date --date="$finaldate" +%s) - $(date +%s) \) / 3600 | bc -l
    echo -ne 'Hours per challenge:\t'
    echo \( $(date --date="$finaldate" +%s) - $(date +%s) \) / 3600 / $pcount  | bc -l
}
function pdone()
{
	pcount=$(grep pcount ~/.plab | head -n1| cut -d '=' -f2)
	pcount=$(($pcount - 1 ))
	sed -i "0,/pcount=/{s/pcount=.*/pcount=$pcount/}" ~/.plab		# match first instance
}

function portswigger()
{
#- [ ] 23 topics 
#- [ ] 224 labs
#- [ ] 10 Mystery labs
#- [ ] 3 Practice exam
	topic=$(grep topic ~/.portswiggerlab | awk -F'=' '{print $2}')
	lab=$(grep lab ~/.portswiggerlab | awk -F'=' '{print $2}')
	mystery=$(grep mystery ~/.portswiggerlab | awk -F'=' '{print $2}')
	practice=$(grep practice ~/.portswiggerlab | awk -F'=' '{print $2}')
    finaldate="20 November 2022"
	
	final_date_sec=$(date --date="$finaldate" +%s)
	current_date_sec=$(date +%s)
	diff_sec=$(($final_date_sec-$current_date_sec))
	diff_hrs=$(echo $(echo $diff_sec/3600) | bc -l)

	days=$(echo $(echo $diff_hrs/24) | bc -l);days=${days%.*}
	if [ -z "$days" ]; then days=0 ;fi
	hrs=$(echo $(echo $diff_hrs-$days*24) | bc -l);hrs=${hrs%.*}
	if [ -z "$hrs" ]; then hrs=0 ;fi
	min=$(echo $(echo $diff_hrs | sed 's/.*\./0./g')*60 | bc -l )

	hr_per_lab=$(echo $(echo $diff_hrs/$lab) | bc -l)
	hr_per_top=$(echo $(echo $diff_hrs/$topic) | bc -l)
	hr_per_mys=$(echo $(echo $diff_hrs/$mystery) | bc -l)

	printf "time:\t\t%2dd %dh %.0fm\n" $days $hrs $min  
	printf 'labs:\t\t%3d\t%5.2f hr/lab\t%.2f lab/day\n' $lab $hr_per_lab $(echo $(echo 24/$hr_per_lab)| bc -l)
	printf 'topics:\t\t%3d\t%3.2f hr/top\t%5.2f top/day\n' $topic $hr_per_top $(echo $(echo 24/$hr_per_top)| bc -l)
	printf 'mystery:\t%3d\t%3.2f hr/mys\n' $mystery $hr_per_mys 

}
function portswiggerdone()
{
	topic=$(grep topic ~/.portswiggerlab | awk -F'=' '{print $2}')
	lab=$(grep lab ~/.portswiggerlab | awk -F'=' '{print $2}')
	mystery=$(grep mystery ~/.portswiggerlab | awk -F'=' '{print $2}')
	practice=$(grep practice ~/.portswiggerlab | awk -F'=' '{print $2}')
	lab=$(($lab - 1 ))
	sed -i "s/lab=.*/lab=$lab/g" ~/.portswiggerlab
	portswigger
}


function up()
{
if [ $# -eq 0 ] && tty -s
	then echo -e "Usage:  up /tmp/file2upload\n\techo 'memes' | up whatever.txt\n\tps aux | up"
	return 0
fi
f="nofilename"
if [ $# -eq 1 ]
	then f=$1
fi
if tty -s
	then curl -# -w "\n" -T $1 temp.sh
else curl -# -w "\n" -T "-" temp.sh/$f
fi
}
###### SET IP UNIVERSALLY #####
function setip()
{
    if [ "$1" != "" ];then
    sed -i -E "s/([0-9]{1,3}\.){3}([0-9]){1,3}/$1/g" /opt/.IP
    sed -i -E "s/([0-9]{1,3}\.){3}([0-9]){1,3}/$1/g" /opt/phprev.php		#updates phprev to IP given
    else
    sed -i -E "s/([0-9]{1,3}\.){3}([0-9]){1,3}/`tun`/g" /opt/.IP
    sed -i -E "s/([0-9]{1,3}\.){3}([0-9]){1,3}/`tun`/g" /opt/phprev.php		#updates phprev to tun
	fi
}
