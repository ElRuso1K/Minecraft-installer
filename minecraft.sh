#!/bin/bash

# Clear the screen
clear

# LEAVE CREDITS
echo "
#######################################################################################
#
#                                  Foxytoux
#
#                           Copyright (C) 2023 - 2024
#
#
#######################################################################################"

# Ask the user for the Minecraft server script URL
read -p "Please enter the URL of the Minecraft server script (press Enter to use the default URL): " server_url
server_url=${server_url:-"https://papermc.io/api/v2/projects/paper/versions/1.16.5/builds/790/downloads/paper-1.16.5-790.jar"}

# Download the Minecraft server script
wget -O server.jar $server_url

# Download openjdk-16-jdk
sudo apt-get update
sudo apt-get install openjdk-16-jdk -y

# Ask the user if they accept the Minecraft EULA
read -p "Do you accept the Minecraft EULA? (Type 'yes' or 'y' to accept): " eula_acceptance

# Check if the user accepted the EULA
if [[ "$eula_acceptance" =~ ^[Yy][Ee][Ss]?$ ]]; then
    # Ask the user for the amount of RAM to allocate
    read -p "How much RAM would you like to allocate to the Minecraft server (in GB)? " ram_amount

    # Modify the Java command with the user's response
    java_command="java -Xms${ram_amount}G -Xmx${ram_amount}G -jar server.jar nogui"

    # Launch the Minecraft server
    $java_command

    # Modify the eula.txt file to set 'true'
    echo "eula=true" > eula.txt

    # Restart the Minecraft server with the new configurations
    $java_command
else
    echo "You must accept the Minecraft EULA to proceed. Aborting."
fi
