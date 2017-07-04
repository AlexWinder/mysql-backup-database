#!/bin/bash

# Specify which databases are to be backed up
db_name=""

# Database credentials
user=""
password=""
host="127.0.0.1"

# Other options
backup_path="/var/backups/mysql"
date=$(date +"%Y%m%d-%H%M")

# Set default file permissions
umask 177

# Dump database into SQL file
mysqldump --lock-tables --user=$user --password=$password --host=$host $db_name                                                                                                                                                              > $backup_path/$db_name-$(hostname -f)-$date.sql

# Delete files older than 30 days
find $backup_path/$db_name*.sql -mtime +30 -type f -delete