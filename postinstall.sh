#!/bin/sh

# Enter the ENROLLMENT_USER within the '' of ENROLLMENT_USER=''
ENROLLMENT_USER=''

# Enter the ENROLLMENT_USER_PASSWORD within the '' of ENROLLMENT_USER_PASSWORD='' with the credentials of the admin with a secure token
ENROLLMENT_USER_PASSWORD=''

cat <<-EOF >/var/run/JumpCloud-SecureToken-Creds.txt
$ENROLLMENT_USER;$ENROLLMENT_USER_PASSWORD
EOF

# Set Permissions
# Install script should be placed in /var/tmp if we want to account for restarts
# files in private/tmp will be deleted by macOS
chmod 744 /var/tmp/jumpcloud_bootstrap_template.sh
chown root:wheel /var/tmp/jumpcloud_bootstrap_template.sh
chmod 644 /Library/LaunchDaemons/com.jumpcloud.prestage.plist
chown root:wheel /Library/LaunchDaemons/com.jumpcloud.prestage.plist

# load the LaunchDaemon
launchctl load -w /Library/LaunchDaemons/com.jumpcloud.prestage.plist