figlet INFO EXTRACTOR
echo "--------------------------------------------------------" 

# 1. Identify the system's public IP.
echo "Your Public Ip address is :$(curl -s ifconfig.me)"
echo ""  # echo for leaving space 


# 2. Identify the private IP address assigned to the system's network interface.
echo "Your local IP address is: $(ifconfig | grep 'broadcast' | awk '{print $2}')" 
echo ""  # echo for leaving space 

# 3. Display the MAC address (masking sensitive portions for security).
echo "Your MAC-Address is : $(ifconfig | grep 'ether' | awk '{print $2}')"
echo ""
# 4. Display the percentage of CPU usage for the top 5 processes.
echo "--------------------------------------------------------"
echo "Top 5 process the are running"
echo ""
ps -eo pid,%cpu,comm --sort=%cpu |tail -n 6 | grep -v 'ps'
echo""
# 5. Display memory usage statistics: total and available memory.
echo "Memory statistis"
echo ""
echo "Total Size:$(free -h | grep 'Mem:'|awk '{print $2}')"
echo "Used Size: $(free -h | grep 'Mem:'|awk '{print $3}')"
echo "Free Size:$(free -h | grep 'Mem:'|awk '{print $4}')"
echo "shared:$(free -h | grep 'Mem:'|awk '{print $5}')"
echo "buff/cashe:$(free -h | grep 'Mem:'|awk '{print $6}')"
echo "Availabe:$(free -h | grep 'Mem:'|awk '{print $7}')"
# 6. List active system services with their status.
echo ""
echo "Active processes"
echo ""
echo "$(service --status-all | grep -F '[ + ]')"
# 7. Locate the Top 10 Largest Files in /home.
echo ""
echo "Top 10 Largest file in home"
echo ""
echo "$(du -ah /home/ | sort -hr | head -n 10)"
echo "------------------------------------------------------"

figlet 'Thank You ! !'

