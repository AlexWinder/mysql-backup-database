# MySQL Database Backup

This is a simple BASH script which can be run on Linux systems running MySQL server which also has MySQLdump enabled. This is used to backup a MySQL database. This can then be run as part of a cron job to easily back up databases to another location.

## Contributors

- [Alex Winder](https://www.alexwinder.uk) 

## Getting Started

### Prerequisites

To be able to use this you must have the following installed:

- MySQL/MariaDB
- MySQLdump

This script has been tested to work on the following systems:

- Debian 8 Jessie
- Debian 9 Wheezy
- MySQL 5.7
- MariaDB 10.1
- MySQLdump 10

### Installing

#### Store the Backup Script

In order for this script to work correctly it is advised that create the correct folder to place the script. For example, ```/var/backups/mysql```

> mkdir -p /var/backups/mysql

The [backup.sh](backup.sh) should be placed in this location.

#### Configure Values

Once the script is in the correct location then the following information is required to be entered on the backup script:

- The database you are wanting to backup (line 4 "db_name").
- The website which the database relates to (line 7 "website").
- The username with access to the database to backup (line 10 "user").
- The password to the username being used to access the MySQL database (line 11 "password"). If no password is required then this can be left as an empty string.
- The host of the MySQL database (line 12 "host"). If this is your local machine then the default value of 127.0.0.1 will be fine.
- The number of days you wish to store SQL backup files for (line 15 "days"). This is by default set to 30 days.

#### Change Permissions

Once the information above has been inserted then the permissions of the file should be changed:

> chmod 700 /var/backups/mysql/backup.sh

If you have specified a different location to the example given above then you will need to adjust the location accordingly.

#### Test Script

The file can then be tested to see if all things work as expected.

> /var/backups/mysql/backup.sh

If you have specified a different location to the example given above then you will need to adjust the location accordingly.

A new directory should be created which will be the same as the value in set in the "website" value. Inside this directory should be a complete SQLdump of the database defined.

If you receive a warning message when testing then double check your values; in particular the database, username, password, and host values. If you are still experiencing issues then it is possible that the user you are connecting as may not have the relevant permissions to run mysqldump.

#### Automate via Cron

The script can now be added to the crontab, if required, to run automatically. To do this first open the crontab:

> crontab -e

Then append the end of the crontab with a new line:

> 0 0 * * * /var/backups/mysql/backup.sh

This will cause the script to run every day at 00:00, from the current logged in user. If you wish to run as a different user then you will need to open the crontab for that particular user. This crontab will create a backup of the MySQL database specified.

## License

This project is licensed under the [MIT License](LICENSE.md).