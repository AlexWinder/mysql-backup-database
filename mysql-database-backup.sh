#!/bin/bash

######################
##### PARAMETERS #####
######################

# Specify which database is to be backed up
database=""

# Database credentials
user="${user:-root}"
password=""
host="${host:-localhost}"

# Set the location of where backups will be stored
to="${to:-/var/backups/mysql}"

# How many days would you like to keep files for?
days="${days:-30}"

# Enable named parameters to be passed in
while [ $# -gt 0 ]; do

    # If help has been requested
    if [[ $1 == *"--help" ]]; then
        echo
        echo "Let's Encrypt Backup Script"
        echo
        echo "This script allows you to easily backup a MySQL or MariaDB database to an SQL dump."
        echo "https://github.com/AlexWinder/mysql-backup-database"
        echo
        echo "Options:"
        echo
        echo "--to        Where you would like to back the files up to. Default: ${to}"
        echo "--database  The name of the database which you would like to back up."
        echo "--user      The username which will be used to access the database and run a backup. Default: ${user}"
        echo "--password  The password relating to the 'user'. Default: ${password}"
        echo "--host      The MySQL/MariaDB server which hosts the database. Default: ${host}"
        echo "--days      The number of days to keep backup files before deleting them. Default: ${days} (days)"
        echo "--help      Display help about this script"
        echo
        exit 0
    fi

    # Check all other passed in parameters
    if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
    fi

    shift
done

# Fail-safe to make sure we have a database
if [ -z "$database" ]; then
    echo "You have not specified which database you wish to back up. Please pass in the --database flag with the name of the database you wish to back up."
    exit 1
fi

######################################################
##### EDITING BELOW MAY CAUSE UNEXPECTED RESULTS #####
######################################################

# Set the date
date=$(date +"%Y%m%d-%H%M")

# Create the directory for the website if it doesn't already exist
mkdir -p ${to}
# Append the database name with the date to the backup location
backup_full_name="${to}/${database}-${date}.sql"

# Set default file permissions
umask 177

# Dump database into SQL file
mysqldump --lock-tables --user=$user --password=$password --host=$host $database > $backup_full_name

# Set a value to be used to find all backups with the same name
find_backup_name="${to}/${database}-*.sql"
# Delete files older than the number of days defined
find $find_backup_name -mtime +$days -type f -delete