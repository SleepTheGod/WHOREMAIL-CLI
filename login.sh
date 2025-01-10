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
    echo "This is the correct sign-up portal: https://register.whor.email/index.php"
    echo
}

# Display the banner
display_banner

# Show help message
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  -h, --help               Show this help message"
    echo "  --email <email>          Enter your email"
    echo "  --password <password>    Enter your password"
    echo "  --key <registration_key> Enter your registration key (for new users)"
    echo
    exit 0
}

# Show command options help
show_command_help() {
    echo "Command Options:"
    echo "1. View inbox: Displays your incoming emails."
    echo "2. Send email: Compose and send a new email."
    echo "3. View settings: Displays your current settings (email and other configurations)."
    echo "4. Start real-time polling for new emails: Check for new emails every 30 seconds."
    echo "5. Read an email: Allows you to read an email by its ID."
    echo "6. Delete an email: Allows you to delete an email by its ID."
    echo "7. Mark an email as read: Mark an email as read by its ID."
    echo "8. Log out: Log out and clear your session."
    echo "9. Exit: Close the application."
    echo
    echo "To execute a command, simply choose the corresponding number from the menu."
    echo "Use 'exit' to leave the application at any time."
    echo
}

# Parse arguments for help or registration
if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    show_help
fi

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
FETCH_EMAILS_URL="https://ewho.re/mail/fetch_emails"
SEND_EMAIL_URL="https://ewho.re/mail/send_email"
FETCH_SENT_EMAILS_URL="https://ewho.re/mail/fetch_sent_emails"
FETCH_OUTBOX_EMAILS_URL="https://ewho.re/mail/fetch_outbox_emails"
DELETE_EMAIL_URL="https://ewho.re/mail/delete_email"
MARK_EMAIL_READ_URL="https://ewho.re/mail/mark_as_read"

# Send login request using curl
response=$(curl -s -X POST -d "email=$EMAIL&password=$PASSWORD" -c cookies.txt "$LOGIN_URL")

# Check if login was successful by looking for a specific message or token
if [[ "$response" == *"Welcome"* || "$response" == *"logged_in"* ]]; then
    echo "Login successful!"
else
    echo "Login failed! Please check your credentials."
    exit 1
}

# Fetch and display incoming emails
fetch_incoming_emails() {
    echo "Checking for new incoming emails..."
    email_response=$(curl -s -X GET -b cookies.txt "$FETCH_EMAILS_URL")
    
    if [[ -z "$email_response" ]]; then
        echo "No new emails found or failed to retrieve emails."
    else
        echo "New incoming emails:"
        echo "$email_response"
    fi
}

# Fetch and display sent emails
fetch_sent_emails() {
    echo "Fetching your sent emails..."
    sent_response=$(curl -s -X GET -b cookies.txt "$FETCH_SENT_EMAILS_URL")
    
    if [[ -z "$sent_response" ]]; then
        echo "No sent emails found."
    else
        echo "Sent emails:"
        echo "$sent_response"
    fi
}

# Fetch and display outbox emails
fetch_outbox_emails() {
    echo "Checking for emails in your outbox..."
    outbox_response=$(curl -s -X GET -b cookies.txt "$FETCH_OUTBOX_EMAILS_URL")
    
    if [[ -z "$outbox_response" ]]; then
        echo "No emails found in the outbox."
    else
        echo "Outbox emails:"
        echo "$outbox_response"
    fi
}

# Send an email
send_email() {
    echo "Sending email..."
    read -p "To: " TO
    read -p "Subject: " SUBJECT
    read -p "Message: " MESSAGE
    
    response=$(curl -s -X POST -d "to=$TO&subject=$SUBJECT&message=$MESSAGE" -b cookies.txt "$SEND_EMAIL_URL")
    
    if [[ "$response" == *"Email sent successfully"* ]]; then
        echo "Email sent successfully!"
    else
        echo "Failed to send email."
    fi
}

# Read an email
read_email() {
    echo "Enter the email ID to read:"
    read EMAIL_ID
    email_response=$(curl -s -X GET -b cookies.txt "$FETCH_EMAILS_URL?id=$EMAIL_ID")
    
    if [[ -z "$email_response" ]]; then
        echo "Email not found."
    else
        echo "Email details:"
        echo "$email_response"
    fi
}

# Delete an email
delete_email() {
    echo "Enter the email ID to delete:"
    read EMAIL_ID
    response=$(curl -s -X POST -d "id=$EMAIL_ID" -b cookies.txt "$DELETE_EMAIL_URL")
    
    if [[ "$response" == *"Email deleted successfully"* ]]; then
        echo "Email deleted successfully!"
    else
        echo "Failed to delete email."
    fi
}

# Mark an email as read
mark_as_read() {
    echo "Enter the email ID to mark as read:"
    read EMAIL_ID
    response=$(curl -s -X POST -d "id=$EMAIL_ID" -b cookies.txt "$MARK_EMAIL_READ_URL")
    
    if [[ "$response" == *"Email marked as read"* ]]; then
        echo "Email marked as read."
    else
        echo "Failed to mark email as read."
    fi
}

# Real-time polling to check for new emails every 30 seconds
real_time_polling() {
    while true; do
        echo "Checking for new emails..."
        fetch_incoming_emails
        fetch_outbox_emails
        fetch_sent_emails
        sleep 30
    done
}

# Main email client menu
while true; do
    echo
    echo "Please select an option:"
    echo "1. View inbox"
    echo "2. Send email"
    echo "3. View settings"
    echo "4. Start real-time polling for new emails"
    echo "5. Read an email"
    echo "6. Delete an email"
    echo "7. Mark an email as read"
    echo "8. Log out"
    echo "9. Exit"
    echo "h. Help"
    read -p "Choose an option: " option
    
    case $option in
        1)
            fetch_incoming_emails
            ;;
        2)
            send_email
            ;;
        3)
            echo "Displaying current settings for $EMAIL"
            ;;
        4)
            real_time_polling
            ;;
        5)
            read_email
            ;;
        6)
            delete_email
            ;;
        7)
            mark_as_read
            ;;
        8)
            echo "Logging out..."
            rm cookies.txt
            exit 0
            ;;
        9)
            echo "Exiting the application."
            exit 0
            ;;
        h)
            show_command_help
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
