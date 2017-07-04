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