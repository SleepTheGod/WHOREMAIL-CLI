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

# Show help message
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  -h, --help                Show this help message"
    echo "  --email <example@example.com>       Enter your email"
    echo "  --password <example> Enter your password"
    echo "  --key <registration_key>           Enter your registration key (required for registration)"
    echo
    echo "Example:"
    echo "  $0 --email example@example.com --password example1234 --key TNGMGhOT41ZK0mpxXtJe.vJnKxNHY0YmbwUTeKxMe2kMUt0vXIElBOn4O1Nm9HoIaGHLXuk"
    exit 0
}

# Parse arguments for help or registration
for i in "$@"; do
    case $i in
        -h|--help)
        show_help
        ;;
        --email)
        EMAIL="$2"
        shift
        shift
        ;;
        --password)
        PASSWORD="$2"
        shift
        shift
        ;;
        --key)
        REG_KEY="$2"
        shift
        shift
        ;;
        *)
        echo "Invalid option: $i"
        show_help
        ;;
    esac
done

# Prompt for registration key if not provided during sign up
if [ -z "$REG_KEY" ]; then
    read -p "Please enter your registration key: " REG_KEY
    echo "You are now registered with the key: $REG_KEY"
    exit 0
fi

# Prompt user for email and password for login if not passed as arguments
if [ -z "$EMAIL" ]; then
    read -p "Please enter your email: " EMAIL
fi

if [ -z "$PASSWORD" ]; then
    read -sp "Please enter your password: " PASSWORD
    echo
fi

# Ensure both email and password are provided
if [ -z "$EMAIL" ] || [ -z "$PASSWORD" ]; then
    echo "Error: Email or password is missing."
    exit 1
fi

# Set the login endpoint URL
LOGIN_URL="https://ewho.re/mail/"
FETCH_EMAILS_URL="https://ewho.re/mail/fetch_emails"  # Modify with the correct URL to fetch emails

# Send login request using curl
response=$(curl -s -X POST -d "email=$EMAIL&password=$PASSWORD" -c cookies.txt "$LOGIN_URL")

# Check if login was successful by looking for a specific message or token
if [[ "$response" == *"Welcome"* || "$response" == *"logged_in"* ]]; then
    echo "Login successful!"

    # Fetch emails after successful login (adjust API/endpoint as needed)
    echo "Fetching your emails..."
    email_response=$(curl -s -X GET -b cookies.txt "$FETCH_EMAILS_URL")

    if [[ -z "$email_response" ]]; then
        echo "No emails found or failed to retrieve emails."
    else
        echo "Emails retrieved successfully!"
        echo "$email_response"  # This can be formatted more nicely depending on the response structure
    fi
else
    echo "Login failed! Please check your credentials."
    exit 1
fi
