# Single MySQL Database Backup

This is a simple BASH script which can be run on all Linux systems running MySQL server which also has MySQLdump enabled.

## Getting Started

### Prerequisites

This has been tested to work on the following systems:

- Debian 8 Jessie
- Debian 9 Wheezy
- MySQL 5.7.18
- MySQLdump 10.13

### Installing

In order for this script to work correctly you first must ensure that you have created the correct folder to place both the script and the SQL dumps.

> mkdir -p /var/backups/mysql

The mysql_backup_script.sh should be placed in this location.

Once the script is in the correct location then the following information is required:

- The database you are wanting to backup
- The username with access to the database to backup
- The password to the username being used to access the MySQL database
- The host of the MySQL database (if this is your local machine then the default value of 127.0.0.1 will be fine)

Once the information above has been inserted then the permissions of the file should be changed:

> chmod 700 /var/backups/mysql/mysql_backup_script

The file can then be tested to see if all things work as expected.

> ./var/backups/mysql/mysql_backup_script

If you now have an SQLdump in the /var/backups/mysql/ then everything is working as expected.

The script can now be added to the crontab, if required, to run automatically. To do this first open the crontab:

> crontab -e

Then append the end of the crontab with a new line:

> 0 0 * * * /var/backups/mysql/mysql_backup_script

This will cause the script to run every day at 00:00, creating a backup of the MySQL database.