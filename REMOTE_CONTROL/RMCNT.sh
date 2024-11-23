#!/bin/bash


# Names: Albert NSABIMANA
# code:  s30
# Unity: RW-University-II
# Lecture: David Shifman 


# This is the INSTALL function to check if necessary tools are available or install it if not 

function INSTALL()
{	
	#1.1 Install the needed applications.
	#1.2 If the applications are already installed, don’t install them again.
	
	echo "[*] Checking the required tools....."           
	echo ""
	echo "
			1.Nmap
			2.Sshpass
			3.Whois
			4.Torify"
	echo ""
	sleep 1
	
	tools=("nmap" "sshpass" "whois" "tor")
	
	# a for loop to loop over the specified tools and check if the tool installed or install it if not 
	for tool in "${tools[@]}"
	do 
		if command -v $tool &> /dev/null
		then
			echo -e "\e[32m   [+] $tool is Already installed. \e[0m"
		else
		     if [ "$tool" == "tor" ]
		     then 
					echo "[*] installing $tool"
					sudo apt install -y tor torbrowser-launcher
			 else
			 
				echo "[*] Installing $tool ....."
				sudo apt-get install $tool 
			fi
		fi
		sleep 1
	done 
echo ""
	
}

# This is the ANON funciton that check if you are anonymous or not, if not it exit the tool 
function ANON()
{
	#1.3 Check if the network connection is anonymous; if not, alert the user and exit.
	#1.4 If the network connection is anonymous, display the spoofed country name.
	
	
	IP=$(curl -s https://icanhazip.com)    # This is one of the ways to fetch your public ip 
	
	if [ "$(geoiplookup $IP | grep RW)" ]
	then 
		
		echo -e "\e[31m ALERT! : You are not anonymous......\e[0m"
		exit
	else 
	     echo -e "[*] The spoofed Country Name: $(geoiplookup $IP | awk '{print $(NF)}')"
	fi 
	echo ""
}


function RMT()
{	#1.5 Allow the user to specify the address to scan via remote server; save into a variable
	#2.1 Display the details of the remote server (country, IP, and Uptime).
	#2.2 Get the remote server to check the Whois of the given address.
	#2.3 Get the remote server to scan for open ports on the given address.
	#3.1 Save the Whois and Nmap data into files on the local computer.

	
	read -p "Enter the Domain to scan: " DMN
	
	# This is the reguration exprassion to check if the specified domain is valid or not or if it is Ip address 
	regex="^(([a-zA-Z0-9]([-a-zA-Z0-9]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}|([0-9]{1,3}\.){3}[0-9]{1,3}|(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}))$"
	
	if [[ $DMN =~ $regex ]]; then

	
		echo ""
		echo "[*] Connecting to the remote server ..."
		sleep 1
		echo "[-] Remote server Detail"
		RIP=172.16.212.130
		# connecting to the remote server directly and get the IP and Uptime.
		
		IP=$(sshpass -p 'tc' ssh -o StrictHostKeyChecking=no  tc@$RIP "curl -s ifconfig.me")
		Uptime=$(sshpass -p 'tc' ssh -o StrictHostKeyChecking=no  tc@$RIP "uptime" )
		
		echo "               - Country: $(geoiplookup $IP | awk '{print $(NF)}')"
		echo "               - IP: $IP"
		echo "               - Uptime: $Uptime"
		echo ""
		
		echo "[*] Whois initiated  on $DMN ..."
		path=$(pwd)
		type="Whois"
		
		# using the remote server and excute the whois command on entered  domain or IP address 
		sshpass -p 'tc' ssh -o StrictHostKeyChecking=no  tc@$RIP "whois $DMN" > Whois_$DMN.info
		echo "[*] Whois information was seved into: $path/Whois_$DMN.info"
		LOG
		cat Whois_$DMN.info | tr 'A-Za-z' 'N-ZA-Mn-za-m' >Whois_$DMN.info.enc # Encrypt the whois collected information and save it 
		echo -e "\e[32m[*] Whois information was Encrypted and saved into :$path/Whois_$DMN.info.enc \e[0m "
		echo ""
		
		sleep 1
		echo "[*] Nmap initiated on $DMN ..."
		type="Nmap"
		# using the remote server and execute the Nmap command on the entered domain or IP address  
		sshpass -p 'tc' ssh -o StrictHostKeyChecking=no  tc@$RIP "nmap $DMN" > Nmap_$DMN.info
		echo "[*] Nmap information was saved into: $path/Nmap_$DMN.info"
		LOG
		cat Nmap_$DMN.info | tr 'A-Za-z' 'N-ZA-Mn-za-m' >Nmap_$DMN.info.enc # save the encrypted version of the collected Nmap info 
		echo -e "\e[32m[*] Nmap information was Encrypted and saved into :$path/Nmap_$DMN.info.enc \e[0m "
		echo ""
	else 
		# Promp the user to enter the valid domail or IP if the entered is wrong 
		echo -e "\e[31m Invalid Domain...  \e[0m"
		RMT
	fi 
	
}

# The LOG funcition that help to log the collected information an save it 

function LOG()
{	#3.2 Create a log and audit your data collecting.
	
	echo "$(date) - [*] $type data  collected for: $DMN" >> tool.log 
}


# This is the main funcition that holds the other funcitons for better calling 

function MAIN()
{
	INSTALL
    ANON
    RMT
}

MAIN

