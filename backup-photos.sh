#!/bin/bash

# author: john dimatteo
# created: 2022-04-20

usage() {                                 # Function: Print a help message.
  echo "Usage: $0 [ -t TARGET_FOLDER ] [ -s SOURCE_FOLDER ]" 1>&2 
}

exit_abnormal() {                         # Function: Exit with error.
  usage
  exit 1
}

while getopts u:a:f: flag
do
    case "${flag}" in
        t) TARGET=${OPTARG};;
        s) SOURCE=${OPTARG};;
    esac
done
echo "Backing up files from: $SOURCE";
echo "To: $TARGET";


TODAY=$(date +'%m/%Y')
rsync -ar --no-relative --progress --files-from=<(find $SOURCE -newer $TARGET/last_sync -type f -exec basename {} \;) $SOURCE $TARGET/$TODAY
touch $TARGET/last_sync