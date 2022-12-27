# MySQL Database Backup

This is a simple BASH script which can be run on Linux systems running MySQL server which also has MySQLdump enabled. This is used to backup a MySQL database. This can then be run as part of a cron job to easily back up databases to another location.

## Contributors

- [Alex Winder](https://www.alexwinder.uk) 

## Prerequisites

To be able to use this you must have the following installed:

- MySQL/MariaDB
- MySQLdump

This script has been tested to work on the following systems:

- Debian 8 Jessie
- Debian 9 Stretch
- Ubuntu 22
- MySQL 5.7
- MariaDB 10.1 & 10.6
- MySQLdump 10

## Usage 

The [mysql-database-backup.sh](mysql-database-backup.sh) script has been designed to work as simply as possible.

The script accepts a number of named parameters which allows you to customise it for your particular environment.

- `--help` - Show a help guide on the script. If used then no other parameters will be considered.
- `--to` - Where you would like to back the files up to. Default: `/var/backups/mysql`.
- `--database` - The name of the database which you would like to back up. This is a required value.
- `--user` - The username which will be used to access the database and run a backup. Default: `root`.
- `--password` - The password relating to the 'user'. Default: `""`.
- `--host` - The MySQL/MariaDB server which hosts the database. Default: `localhost`.
- `--days` - The number of days to keep backup files before deleting them. Default: `30` (days).

The script is then executed on the command line, with the minimum required parameter of `--database`.

```bash
./mysql-database-backup.sh --database <database_name>
```

This will create the database backup in the value set in the `--to` parameter, by default this is `/var/backups/mysql`. Please note that this directory will be created if it doesn't already exist.

You are free to make use of any of the named parameters to customise for your particular usecase. An example usage is listed below:

```bash
./mysql-database-backup.sh --database my_website_database --to /home/user/backups --user w_user1 --password TopSecretSQLPassword --host db.container --days 1000
```

The above example will backup the `my_website_database` database as an SQL dump into the `/home/user/backups` directory, making use of a user of `w_user1` with a password of `TopSecretSQLPassword`, on the MySQL/MariaDB server host of `db.container`. Backups will be kept for a minimum of `1000` days before being deleted automatically when the script is next run.

If you receive a warning message when testing then double check your values; in particular the database, username, password, and host values. If you are still experiencing issues then it is possible that the user you are connecting as may not have the relevant permissions to run mysqldump.

## Automate via Cron

The script can now be added to the crontab, if required, to run automatically. To do this first open the crontab:

```bash
crontab -e
```

Then append the end of the crontab with a new line:

```bash
0 0 * * * /var/backups/mysql/mysql-database-backup.sh --database <database_name>
```

This will cause the script to run every day at 00:00, from the current logged in user. If you wish to run as a different user then you will need to open the crontab for that particular user. This crontab will create a backup of the MySQL/MariaDB database specified.

## License

This project is licensed under the [MIT License](LICENSE.md).
