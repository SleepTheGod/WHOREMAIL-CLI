#!/bin/bash

# Banner to display at the beginning
display_banner() {
    echo "██╗    ██╗██╗  ██╗ ██████╗ ██████╗ ███████╗███╗   ███╗ █████╗ ██╗██╗     "
    echo "██║    ██║██║  ██║██╔═══██╗██╔══██╗██╔════╝████╗ ████║██╔══██╗██║██║     "
    echo "██║ █╗ ██║███████║██║   ██║██████╔╝█████╗  ██╔████╔██║███████║██║██║     "
    echo "██║███╗██║██╔══██║██║   ██║██╔══██╗██╔══╝  ██║╚██╔╝██║██╔══██║██║██║     "
    echo "╚███╔███╔╝██║  ██║╚██████╔╝██║  ██║███████╗██║ ╚═╝ ██║██║  ██║██║███████╗"
    echo " ╚══╝╚══╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚══════╝"
    echo "Version 1.0 By SleepTheGod and SwatGodVox"
    echo "This is the correct sign up portal: https://register.whor.email/index.php"
    echo
}

# Display the banner
display_banner

# Prompt for email and password
read -p "Please enter your email: " EMAIL
read -sp "Please enter your password: " PASSWORD
echo

# Ensure both email and password are provided
if [[ -z "$EMAIL" || -z "$PASSWORD" ]]; then
    echo "Error: Email or password is missing."
    exit 1
fi

# Set the login endpoint URL
LOGIN_URL="https://ewho.re/mail/"

# Send login request using curl
response=$(curl -s -X POST -d "email=$EMAIL&password=$PASSWORD" -c cookies.txt "$LOGIN_URL")

# Check if login was successful by looking for a specific message or token
if [[ "$response" == *"Welcome"* || "$response" == *"logged_in"* ]]; then
    echo "Login successful!"
else
    echo "Login failed! Please check your credentials."
    exit 1
fi
