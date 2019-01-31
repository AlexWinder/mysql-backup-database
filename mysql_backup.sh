#!/bin/bash

# Specify which database is to be backed up
db_name=""

# Set the website which this database relates to
website=""

# Database credentials
user="root"
password=""
host="localhost"

# How many days would you like to keep files for?
days="30"

######################################################
##### EDITING BELOW MAY CAUSE UNEXPECTED RESULTS #####
######################################################

# Set the date
date=$(date +"%Y%m%d-%H%M")

# Set the location of where backups will be stored
backup_location="/var/backups/mysql"

# Create the directory for the website if it doesn't already exist
mkdir -p ${backup_location}/${website}
# Append the database name with the date to the backup location
backup_full_name="${backup_location}/${website}/${db_name}-${date}.sql"

# Set default file permissions
umask 177

# Dump database into SQL file
mysqldump --lock-tables --user=$user --password=$password --host=$host $db_name > $backup_full_name

# Delete files older than the number of days defined
find $backup_full_name -mtime +${days} -type f -delete