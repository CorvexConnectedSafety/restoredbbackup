#!/bin/bash
# RestoreDBBackup - initial upload
# This script will automate restoring a single database from backup along with incrementals.
# The menu will allow the user to select whether or not they wish to restore the individual db
# or the db with any incremental backups applied to it. 
# more detailed comments will be added as I go along - George Jones

cd /backup/cluster/cluster
dirs=(*/)

read -p "$(
        f=0
        for dirname in "${dirs[@]}" ; do
                echo "$((++f)): $dirname"
        done

        echo -ne 'Please select a backup date > '
)" selection

selected_dir="${dirs[$((selection-1))]}"

echo "You selected '$selected_dir'"

cd /backup/cluster/cluster/${selected_dir}
dirs=(*/)

read -p "$(
        f=0
        for dirname in "${dirs[@]}" ; do
                echo "$((++f)): $dirname"
        done

        echo -ne 'Please select a backup date > '
)" selection

subscriber_dir="${dirs[$((selection-1))]}"

echo "You selected '$subscriber_dir'"

echo "The backup to be restored is '$subscriber_dir' created on '$selected_dir'."
read -p "Is This Correct?" -n 1 -r
echo    # just adding a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
