#!/bin/bash



#simple design: # if remote server $1 available create new on local and ssh-copy-id to remote, then delete old

#best practice: # if remote server $1 available a. backup old. b. create new on local and ssh-copy-id to remote, c. [test] verify ssh to remo>

# Get the current date and time

now=$(date +"%Y-%m-%dT%H:%M:%SZ")



# Get the name of the old SSH key

old_key_name="Aanchal-key-upes"

#backup
cp -a $old_key_name /tmp/$old_key_name-$now


# Get the name ofnashpaz123.pem the new SSH key

new_key_name="new_ssh_key"
# Generate a new SSH key

ssh-keygen -t rsa -b 2048 -f $new_key_name



# Copy the new SSH key to the remote server
ssh-copy-id -i $new_key_name.pub ubuntu@$1

#test the new key

ssh -i $new_key_name ubuntu@$1; if [ echo $? == 0 ] then exit

# Delete the old SSH key

rm $old_key_name.pub $old_key_name

# Update the authorized_keys file on the remote server

ssh ubuntu@$1 "cat "$new_key_name".pub >> .ssh/authorized_keys"
# Notify the user that their SSH keys have been rotated

echo "Your SSH keys have been rotated successfully."

