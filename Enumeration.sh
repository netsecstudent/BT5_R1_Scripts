#A great enumeration script used to extract data
#for any given domain. Enjoy!

echo "What site would you like to scan?"
read domain
echo ' ' >results_$domain.txt
echo "Nmap Scan Started"
nmap -sS -Pn $domain >>~/results_$domain.txt
nmap -Pn -sS -A $domain >>~/results_$domain.txt
echo "Nmap Scan Complete"
echo "DNSEnum Scan Started"
/pentest/enumeration/dns/dnsenum/./dnsenum.pl $domain >> ~/results_$domain.txt
echo "DNSEnum Scan Complete"
#/pentest/enumeration/dns/dnsmap/./dnsmap $domain >> ~/results_$domain.txt
echo "Dmitry Scan Started"
dmitry -wsne $domain >> ~/results_$domain.txt
echo "The Harvester Scan Started"
/pentest/enumeration/theharvester/./theHarvester.py -d $domain -l 1000 -b google >>~/results_$domain.txt
/pentest/enumeration/theharvester/./theHarvester.py -d $domain -l 1000 -b linkedin >>~results_$domain.txt
echo "The Harvest Scan Complete"

echo "Scan Complete, Press Enter to view Results"
read blah blah

kwrite results_$domain.txt
