#!/bin/bash

# User Management Script

# Function to display the menu
display_menu() {
    echo "User Management Menu"
    echo "1. Create User"
    echo "2. Modify User"
    echo "3. Delete User"
    echo "4. Create Group"
    echo "5. Add User to Group"
    echo "6. Remove User from Group"
    echo "7. Change User Password"
    echo "8. View User Details"
    echo "9. Exit"
}

# Function to create a user
create_user() {
    read -p "Enter username: " username
    read -p "Enter password: " password
    sudo useradd -m "$username"
    echo "$username:$password" | sudo chpasswd
    echo "User $username created."
}

# Function to modify a user
modify_user() {
    read -p "Enter username to modify: " username
    read -p "Enter new username (leave blank to skip): " new_username
    read -p "Enter new password (leave blank to skip): " new_password
    
    if [[ ! -z "$new_username" ]]; then
        sudo usermod -l "$new_username" "$username"
        echo "Username changed to $new_username."
    fi
    
    if [[ ! -z "$new_password" ]]; then
        echo "$new_username:$new_password" | sudo chpasswd
        echo "Password updated."
    fi
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " username
    sudo userdel -r "$username"
    echo "User $username deleted."
}

# Function to create a group
create_group() {
    read -p "Enter group name: " groupname
    sudo groupadd "$groupname"
    echo "Group $groupname created."
}

# Function to add user to a group
add_user_to_group() {
    read -p "Enter username: " username
    read -p "Enter group name: " groupname
    sudo usermod -aG "$groupname" "$username"
    echo "User $username added to group $groupname."
}

# Function to remove user from a group
remove_user_from_group() {
    read -p "Enter username: " username
    read -p "Enter group name: " groupname
    sudo gpasswd -d "$username" "$groupname"
    echo "User $username removed from group $groupname."
}

# Function to change user password
change_user_password() {
    read -p "Enter username: " username
    read -p "Enter new password: " new_password
    echo "$username:$new_password" | sudo chpasswd
    echo "Password for $username changed."
}

# Function to view user details
view_user_details() {
    read -p "Enter username: " username
    id "$username"
}

# Main loop
while true; do
    display_menu
    read -p "Select an option (1-9): " option

    case $option in
        1) create_user ;;
        2) modify_user ;;
        3) delete_user ;;
        4) create_group ;;
        5) add_user_to_group ;;
        6) remove_user_from_group ;;
        7) change_user_password ;;
        8) view_user_details ;;
        9) exit 0 ;;
        *) echo "Invalid option, please try again." ;;
    esac

    echo ""
done
