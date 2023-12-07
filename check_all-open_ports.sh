#!/bin/bash

# Function to check if a port is open using nc
check_port() {
    host=$1
    port=$2
    (echo >/dev/tcp/"$host"/"$port") &>/dev/null && echo "Port $port is open" || echo "Port $port is closed"
}

# Prompt user for server IP
read -p "Enter your server IP: " host



ports=("80" "443" "22" "8080" "3000")

# Check each specified port
for port in "${ports[@]}"; do
    check_port "$host" "$port"
done




#check all open ports with nmap.
#!/bin/bash

# Function to check if a port is open
#check_port() {
#    host=$1
#    port=$2
#    timeout 1 bash -c "</dev/tcp/$host/$port" &>/dev/null && echo "Port $port is open" || echo "Port $port is closed"
#}

# Prompt user for server IP
#read -p "Enter your server IP: " host

# Get a list of all open ports
#open_ports=$(nmap -p- --open --min-rate=1000 -T4 "$host" | grep ^[0-9] | cut -d '/' -f 1)

# Check each open port
#for port in $open_ports; do
#    check_port "$host" "$port"
#done



#check all port from 0 to 65535

#!/bin/bash

# Function to check if a port is open using nc
#check_port() {
#    host=$1
#    port=$2
#    (echo >/dev/tcp/"$host"/"$port") &>/dev/null && echo "Port $port is open" || echo "Port $port is closed"

#}

# Prompt user for server IP
#read -p "Enter your server IP: " host

# Specify the range of ports you want to check
#start_port=1
#end_port=65535

# Check each port in the specified range
#for ((port = start_port; port <= end_port; port++)); do
#    check_port "$host" "$port"
#done
