#Shell script for mysql databases backups:



#!/bin/bash

DIR=/home/mgt/db_backups

function backup()  {
    echo -n "Do you want to backup your databases? (y/n) "
    read answer
    if [ "${answer,,}" == "y" ] || [ "${answer,,}" == "yes" ]
    then
        if [ -d $DIR ]
        then
	        rm -rf $DIR
		    mkdir /home/mgt/db_backups
        	for DB in $(mysql -h"localhost" -u"root" -p"uP0JUMvqjFa6qUtuTCYegKv2" -e "show databases;" | sed s/"Database"// | sed s/"information_schema"// | sed s/"mysql"// | sed s/"performance_schema"// | sed s/"sys"// | xargs -0 );
        	do
        		mysqldump -h"localhost" -u"root" -p"uP0JUMvqjFa6qUtuTCYegKv2" --opt --single-transaction --quick --routines $DB  > "/home/mgt/db_backups/$DB.sql";
        	done
        else
		    mkdir /home/mgt/db_backups
        	for DB in $(mysql -h"localhost" -u"root" -p"uP0JUMvqjFa6qUtuTCYegKv2" -e "show databases;" | sed s/"Database"// | sed s/"information_schema"// | sed s/"mysql"// | sed s/"performance_schema"// | sed s/"sys"// | xargs -0 );
        	do
        		mysqldump -h"localhost" -u"root" -p"uP0JUMvqjFa6qUtuTCYegKv2" --opt --single-transaction --quick --routines $DB  > "/home/mgt/db_backups/$DB.sql";
        	done

        fi
        echo -e "\e[0;32mBackup completed\e[0m"
        echo -e "\n\e[0;32mThe DB backups can be found in $DIR\e[0m\n"
    else
        echo -e "\e[1;33mSkipping backup\e[0m"
    fi
}

backup

