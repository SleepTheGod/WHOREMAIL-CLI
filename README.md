![image](https://github.com/user-attachments/assets/c37617fa-37d0-4479-9844-43c3b91a8743)

![image](https://github.com/user-attachments/assets/31c20865-063a-405b-9023-7b28b80e0bf3)

# WHOREMAIL CLI
```
██╗    ██╗██╗  ██╗ ██████╗ ██████╗ ███████╗███╗   ███╗ █████╗ ██╗██╗     
██║    ██║██║  ██║██╔═══██╗██╔══██╗██╔════╝████╗ ████║██╔══██╗██║██║     
██║ █╗ ██║███████║██║   ██║██████╔╝█████╗  ██╔████╔██║███████║██║██║     
██║███╗██║██╔══██║██║   ██║██╔══██╗██╔══╝  ██║╚██╔╝██║██╔══██║██║██║     
╚███╔███╔╝██║  ██║╚██████╔╝██║  ██║███████╗██║ ╚═╝ ██║██║  ██║██║███████╗
 ╚══╝╚══╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚══════╝
Version 1.0 By SleepTheGod And SwatGodVox
```
# This is a command line interface script for the WHOREMAIL service.

# Overview
The WHOREMAIL CLI allows you to interact with the WHOREMAIL platform to register and log in using an email and password. It also supports registration with a key.

# Features
- Display a banner with information about the project
- Show a help message with usage details
- Registration with a key
- Login with an email and password
- Fetch emails after login

# Usage
Run the script with the following options:
-h or --help          Show the help message
--email                Provide your email address
--password             Provide your password
--key                  Provide your registration key (this is required for registration)

# Example
To register with an email password and key:
./cli.sh --email example@example.com --password example1234 --key TNGMGhOT41ZK0mpxXtJe.vJnKxNHY0YmbwUTeKxMe2kMUt0vXIElBOn4O1Nm9HoIaGHLXuk

# To log in with just email and password:
./cli.sh --email example@example.com --password example1234

# How it works
The script will display a banner with version and information about the project when it is executed.

If the --key option is provided the script will prompt for the key and allow registration. 

If the --email and --password options are provided the script will log in to the platform and fetch emails associated with the account.

# Requirements
To use this script you will need curl installed.

# License
This project is open-source and available under the MIT License.

# Links
This is the correct sign up portal: https://register.whor.email/index.php
