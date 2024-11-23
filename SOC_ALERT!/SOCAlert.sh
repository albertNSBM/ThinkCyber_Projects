#SOC Alert Tool 


#Project: SOC Alert 

    #• Alert when found failed attempt 
    #• Display the Ip address that did it 
    #• Display the country of the attacker 
ln=0
LOC=/var/log/auth.log
while true
do    
      
	for i in $(cat $LOC |awk "NR>$ln"| grep Failed -i | awk '{print $(NF-3)}')
	do 
	    ln=$(cat $LOC | wc -l) 
		country=$(geoiplookup $i | awk '{$1=$2=$3=$4="";print $0}'| sed 's/ //g')
		echo "[*] ALERT: BF DETECTED:[$(date)] [IP:$i] [Country:$country]"
	done
	sleep 2 
done 
